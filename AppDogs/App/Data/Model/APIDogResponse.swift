//
//  APIDogResponse.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

struct APIDogResponse: Codable {
    let name: String
    let description: String
    let age: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name = "dogName"
        case description
        case age
        case image
    }
}
