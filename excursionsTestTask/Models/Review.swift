//
//  Review.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import Foundation

struct Review: Codable {
    
    var id: String
    var generalRating: Int
    var guideRating: Int
    var presentationRating: Int
    var stepsNavigationRating: Int
    var impressionDetail: String
    var improvementSuggestion: String
    
}
