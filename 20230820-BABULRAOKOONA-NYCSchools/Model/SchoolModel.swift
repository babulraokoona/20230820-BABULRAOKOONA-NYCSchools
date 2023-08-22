//
//  SchoolModel.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import Foundation

struct SchoolModel: Decodable, Identifiable, Equatable {
    
    var id: String
    var schoolName: String
    var overview: String
    var phoneNumber: String
    var schoolEmail: String?
    var website: String
    var latitude: String?
    var longitude: String?
}

extension SchoolModel {
    
    private enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case overview = "overview_paragraph"
        case id = "dbn"
        case phoneNumber = "phone_number"
        case schoolEmail = "school_email"
        case website, latitude, longitude
    }
}

extension SchoolModel {
    
    static var schoolModelStub: SchoolDataViewModel {
        return SchoolDataViewModel(schoolModel: SchoolModel(
            id: "",
            schoolName: "",
            overview: "",
            phoneNumber: "",
            schoolEmail: "",
            website: "",
            latitude: "",
            longitude: ""))
    }
}
