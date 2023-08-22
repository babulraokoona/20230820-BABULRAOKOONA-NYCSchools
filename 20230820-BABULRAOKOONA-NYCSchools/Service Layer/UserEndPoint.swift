//
//  UserEndPoint.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Foundation

enum UserEndPoint: APIEndPoint {
    
    case getSchoolsList
    case getDetailData
    
    var baseURL: URL {
        return URL(string: Constants.serverPath)!
    }
    
    var path: String {
        switch self {
        case .getSchoolsList:
            return "/s3k6-pzi2.json"
        case .getDetailData:
            return "/f9bf-2cp4.json"
        }
    }
}
