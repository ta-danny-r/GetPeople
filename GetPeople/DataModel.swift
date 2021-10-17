//
//  DataModel.swift
//  GetPeople
//
//  Created by Danny on 10/17/21.
//

import Foundation

struct DataModel: Codable {
    var results: [Results]
    
}

struct Results: Codable {
    var name, height, mass, hairColor: String
    var skinColor, eyeColor, birthYear, gender: String
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        
    }
    
}
