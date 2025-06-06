//
//  DataConstants.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

struct DataConstants {
    enum APIClient {
        static let contentType: String = "Content-Type"
    }
    
    enum InnerConstants {
        static let applicationJson: String = "application/json"
    }
    struct Ws {
        static let getDogs: String = "1151549092634943488"
    }
    
    static let baseUrl: String = "https://pokeapi.co/api/v2/pokemon/"
}
