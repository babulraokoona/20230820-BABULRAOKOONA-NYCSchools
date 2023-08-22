//
//  SchoolDataViewModel.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import Combine
import Foundation
import MapKit
import SwiftUI

final class SchoolDataModel: ObservableObject {
    
    // MARK: - Publishers
    
    @Published var schools = [SchoolDataViewModel]()
    @Published var state: State = .none
    @Published var hasError = false
    
    // MARK: - Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    //To fetch the High Schools data
    func fetchSchoolData() {
        self.state = .loading
        self.hasError = false
        self.client
            .request(UserEndPoint.getSchoolsList,
                     ofType: [SchoolModel].self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    print("Error: \(error)")
                    self?.hasError = true
                    self?.state = .failure(error)
                }
            } receiveValue: { [weak self] schools in
                self?.state = .success(schools.map(SchoolDataViewModel.init))
            }
            .store(in: &cancellables)
    }
}

extension SchoolDataModel {
    
    enum State {
        case none
        case loading
        case success([SchoolDataViewModel])
        case failure(Error)
    }
}

extension SchoolDataModel.State {
    
    var failureReason: String {
        if case let .failure(error) = self {
            return error.errorDescription
        }
        return "Something went worng"
    }
}

extension SchoolDataModel.State: Equatable {
    
    static func == (lhs: SchoolDataModel.State, rhs: SchoolDataModel.State) -> Bool {
        switch(lhs, rhs) {
        case (.none, .none): return true
        case (.loading, .loading): return true
        case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
            return receivedError == expectedError
        case let (.success(receivedResult), .success(expectedResult)):
            return receivedResult == expectedResult
        default: return false
        }
    }
}

struct SchoolDataViewModel: Equatable {
    
    private var schoolModel:SchoolModel
    
    init(schoolModel: SchoolModel) {
        self.schoolModel = schoolModel
    }
    
    var id:String {
        return schoolModel.id
    }
    var schoolName:String {
        return schoolModel.schoolName
    }
    var overview: String {
        return schoolModel.overview
    }
    var phoneNumber: String {
        return schoolModel.phoneNumber
    }
    var schoolEmail: String {
        return schoolModel.schoolEmail ?? ""
    }
    var website: String {
        return schoolModel.website
    }
    var latitude: String {
        return schoolModel.latitude ?? ""
    }
    var longitude: String {
        return schoolModel.longitude ?? ""
    }
}
