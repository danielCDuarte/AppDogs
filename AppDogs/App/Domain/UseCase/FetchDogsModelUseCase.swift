//
//  FetchDogsModelUseCase.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class FetchDogsModelUseCase: AnyUseCase< Any?, [DogObject]> {
    let repository: PersistenceRepositoriesType
    
    init(repository: PersistenceRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: Any?) async throws -> [DogObject] {
        do {
            return try await self.repository.fetchDogs()
        } catch {
            throw error
        }
    }
}
