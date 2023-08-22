//
//  JsonDecoder.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .useDefaultKeys
    jsonDecoder.dateDecodingStrategy = .deferredToDate
    return jsonDecoder
}()
