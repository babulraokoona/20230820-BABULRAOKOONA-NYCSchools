//
//  SchoolDetailViewModel.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import Combine
import Foundation

final class SchoolDetailViewModel: ObservableObject {
    
    @Published var schoolSat: SchoolSatModel?
    @Published var hasError = false
     
    
    private let client: APIClient
    private var cancellables = Set<AnyCancellable>()
    
    var errorReason = ""
    
    init(client: APIClient) {
        self.client = client
    }
    
    //To fetch the SAT Scores data
    func fetchSchoolStats(by identifier: String) {
        self.client.request(UserEndPoint.getDetailData, ofType: [SchoolSatModel].self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    print(error)
                    self?.errorReason = error.errorDescription
                    self?.hasError = true
                }
            } receiveValue: { [weak self] schoolSats in
                self?.filterSchoolSats(schoolSats, using: identifier)
            }
            .store(in: &cancellables)
    }
    
    //To filter the respective School from the whole data.
    private func filterSchoolSats(_ schoolSats: [SchoolSatModel], using identifier: String) {
        self.schoolSat = schoolSats.filter { $0.id == identifier }.first
    }
}
