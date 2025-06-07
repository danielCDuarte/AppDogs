//
//  GetDogsUseCase.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class GetDogsUseCase: AnyUseCase< Any?, [DogObject]> {
    let repository: DogsRepositoriesType
    
    init(repository: DogsRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: Any?) async throws -> [DogObject] {
        do {
            return try await self.repository.getDogs()
        } catch {
            throw error
        }
    }
}
