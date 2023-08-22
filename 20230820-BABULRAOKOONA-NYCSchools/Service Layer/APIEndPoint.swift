//
//  APIEndPoint.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 20/08/23.
//

import Foundation

protocol APIEndPoint {
    var baseURL: URL { get }
    var path: String { get }
}

extension APIEndPoint {
    var url: URL? {
        return baseURL.appendingPathComponent(path)
    }
}
