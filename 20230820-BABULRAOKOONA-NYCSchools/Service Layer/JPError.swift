//
//  JPError.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

enum JPError: Error {
    
    case invalidURL
    case invalidResponse
    case invalidData
    case unknownError
    case decodingError
}

extension JPError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .invalidData: return "Data is corrupted"
        case .invalidResponse: return "Not a valid response"
        case .invalidURL: return "Not a valid url"
        case .unknownError: return "Unknown error"
        case .decodingError: return "Decoding failed"
        }
    }
}
