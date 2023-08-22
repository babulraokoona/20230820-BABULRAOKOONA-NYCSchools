//
//  DecodingError+JPError.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

extension DecodingError {
    
    var decodingFailed: JPError {
        return JPError.decodingError
    }
}
