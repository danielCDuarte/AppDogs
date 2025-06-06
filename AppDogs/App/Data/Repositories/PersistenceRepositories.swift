//
//  PersistenceRepositories.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class PersistenceRepositories: PersistenceRepositoriesType {
    private(set) var persistenceService: PersistenceServiceType
    
    init(persistenceService: PersistenceServiceType) {
        self.persistenceService = persistenceService
    }
    
    func save(dog: DogModel) async throws {
        do {
            try self.persistenceService.save(dog)
        } catch {
            throw error
        }
    }
    
    func fetchDogs() async throws -> [DogObject] {
        do {
            let dogs = try self.persistenceService.fetch(DogModel.self)
            return DogsModelMapper.map(input: dogs)
        } catch {
            throw error
        }
    }
}

