//
//  DogMapper.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

struct DogMapper: MapperType {
    typealias Input = APIDogResponse
    typealias Output = DogObject
    
    static func map(input: APIDogResponse) -> DogObject {
        return .init(
            name: input.name,
            age: input.age,
            image: input.image
        )
    }
}
