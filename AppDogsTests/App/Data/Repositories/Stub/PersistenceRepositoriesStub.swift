//
//  PersistenceRepositoriesStub.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs

final class PersistenceRepositoriesStub {
    static var error: Error?
    static var responseSave: Void!
    static var responseFetchDogModel: [DogObject]!
}

extension PersistenceRepositoriesStub: PersistenceRepositoriesType {
    func save(dog: AppDogs.DogModel) async throws {
        let data: Void = PersistenceRepositoriesStub.responseSave ?? Void()
        if let error = PersistenceRepositoriesStub.error {
            throw error
        }
        return data
    }
    
    func fetchDogs() async throws -> [AppDogs.DogObject] {
        let data: [DogObject] = PersistenceRepositoriesStub.responseFetchDogModel ?? []
        if let error = PersistenceRepositoriesStub.error {
            throw error
        }
        return data
    }
    
}


