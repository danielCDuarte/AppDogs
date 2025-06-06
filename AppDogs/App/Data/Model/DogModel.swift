//
//  DogModel.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
import SwiftData

@Model
final class DogModel {
    var id: UUID
    var name: String
    var desc: String
    var age: Int
    var image: String
    
    init(
        id: UUID = UUID(),
        name: String,
        desc: String,
        age: Int,
        image: String
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.age = age
        self.image = image
    }
}

