//
//  SchoolSatModel.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import Foundation

struct SchoolSatModel: Decodable, Identifiable, Equatable {
    
    var id: String
    var schoolName: String
    var satTestTakersCount: String
    var satCriticalReadingAvgScore: String
    var satMathAvgScore: String
    var satWritingAvgScore: String
}

extension SchoolSatModel {
    
    private enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case satTestTakersCount = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}
