//
//  DogsMapper.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

struct DogsMapper: MapperType {
    typealias Input = [APIDogResponse]
    typealias Output = [DogObject]
    
    static func map(input: [APIDogResponse]) -> [DogObject] {
        return input.map{
            getDog(input: $0)
        }
    }
    
    private static func getDog(input: APIDogResponse) -> DogObject {
        return .init(
            id: UUID(),
            name: input.name,
            age: input.age,
            image: input.image
        )
    }
}
