//
//  APIClient.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Combine

protocol APIClient {
    typealias FuturePublisher<T> = Future<T, Error>
    func request<T: Decodable>(_ endPoint: APIEndPoint, ofType type: T.Type) -> FuturePublisher<T>
}
