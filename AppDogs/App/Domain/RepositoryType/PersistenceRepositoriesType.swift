//
//  PersistenceRepositoriesType.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

protocol PersistenceRepositoriesType {
    func save(dog: DogModel) async throws
    func fetchDogs() async throws -> [DogObject]
}
