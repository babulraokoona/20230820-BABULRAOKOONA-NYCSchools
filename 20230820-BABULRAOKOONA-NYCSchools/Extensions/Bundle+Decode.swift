//
//  Bundle+Decode.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Foundation

extension Bundle {
    
    enum BundleError: Error {
        case resourcePathNotFound
        case corruptedData
    }
    
    func decode<T: Decodable>(from filename: String, of type: T.Type = T.self, fileExtension: String) throws -> T {
        guard let url = url(forResource: filename, withExtension: fileExtension) else {
            throw BundleError.resourcePathNotFound
        }
        
        let attributedString = try NSAttributedString(
            url: url,
            options: [.documentType: NSAttributedString.DocumentType.rtf],
            documentAttributes: nil)
        guard let data = attributedString.string.data(using: .utf8) else {
            throw BundleError.corruptedData
        }
        return try jsonDecoder.decode(type, from: data)
    }
}
