//
//  URLSessionClient.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Foundation
import Combine

final class URLSessionClient: APIClient {
    
    private var cancellable = Set<AnyCancellable>()
    
    func request<T: Decodable>(_ endPoint: APIEndPoint, ofType type: T.Type = T.self) -> FuturePublisher<T> {
        return FuturePublisher<T> { [weak self] completion in
            guard let self = self else { return }
            guard let url = endPoint.url else {
                completion(.failure(JPError.invalidURL))
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { (data, response) -> Data in
                    guard let response = response as? HTTPURLResponse, 200..<299 ~= response.statusCode else {
                        completion(.failure(JPError.invalidResponse))
                        return Data()
                    }
                    return data
                }
                .decode(type: type, decoder: jsonDecoder)
                .receive(on: DispatchQueue.main)
                .sink { result in
                    if case let .failure(error) = result {
                        switch error {
                        case let decodingError as DecodingError:
                            completion(.failure(decodingError.decodingFailed))
                        case let apiError as JPError:
                            completion(.failure(apiError))
                        default:
                            completion(.failure(error))
                        }
                    }
                } receiveValue: {
                    completion(.success($0))
                }
                .store(in: &self.cancellable)
        }
    }
}
