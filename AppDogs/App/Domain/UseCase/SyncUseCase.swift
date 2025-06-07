//
//  SyncUseCase.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class SyncUseCase: AnyUseCase< Any?, [DogObject]> {
    private let fetchDogsModelUseCase: AnyUseCase< Any?, [DogObject]>
    private let getDogsUseCase: AnyUseCase< Any?, [DogObject]>
    private let saveDogModelUseCase: AnyUseCase< DogObject, Void>
    private let userDefaults: UserDefaults
    
    init(
        fetchDogsModelUseCase: AnyUseCase<Any?, [DogObject]>,
        getDogsUseCase: AnyUseCase<Any?, [DogObject]>,
        saveDogModelUseCase: AnyUseCase<DogObject, Void>,
        userDefaults: UserDefaults = .standard) {
            self.fetchDogsModelUseCase = fetchDogsModelUseCase
            self.getDogsUseCase = getDogsUseCase
            self.saveDogModelUseCase = saveDogModelUseCase
            self.userDefaults = userDefaults
        }
    
    override func execute(params: Any?) async throws -> [DogObject] {
        if !userDefaults.bool(forKey: "hasLaunchedBefore") {
            let dogs = try await getDogsUseCase.execute(params: params)
            for dog in dogs {
                try await saveDogModelUseCase.execute(params: dog)
            }
            userDefaults.set(true, forKey: "hasLaunchedBefore")
            return dogs
        } else {
            let dogs = try await fetchDogsModelUseCase.execute(params: params)
            return dogs
        }
    }
}
