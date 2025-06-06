//
//  DogsModelMapper.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

struct DogsModelMapper: MapperType {
    typealias Input = [DogModel]
    typealias Output = [DogObject]
    
    static func map(input: [DogModel]) -> [DogObject] {
        return input.map{
            getDog(input: $0)
        }
    }
    
    private static func getDog(input: DogModel) -> DogObject {
        return .init(
            id: input.id,
            name: input.name,
            age: input.age,
            image: input.image
        )
    }
}

