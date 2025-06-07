//
//  SaveDogModelUseCase.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class SaveDogModelUseCase: AnyUseCase< DogObject, Void> {
    let repository: PersistenceRepositoriesType
    
    init(repository: PersistenceRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: DogObject) async throws -> Void {
        do {
            return try await self.repository.save(dog: .init(
                name: params.name,
                desc: params.desc,
                age: params.age,
                image: params.image)
            )
        } catch {
            throw error
        }
    }
}
