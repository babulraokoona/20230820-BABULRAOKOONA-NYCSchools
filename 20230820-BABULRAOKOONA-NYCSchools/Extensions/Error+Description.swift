//
//  Error+Description.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Foundation

extension Error {
    
    var errorDescription: String {
        if let error = self as? JPError {
            return error.description
        }
        return self.localizedDescription
    }
}
