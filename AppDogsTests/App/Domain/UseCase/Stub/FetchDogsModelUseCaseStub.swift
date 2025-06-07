//
//  FetchDogsModelUseCaseStub.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
@testable import AppDogs

class FetchDogsModelUseCaseStub: AnyUseCase< Any?, [DogObject]> {
    static var error: Error?
    static var response: [DogObject]!
    
    override func execute(params: Any?) async throws -> [DogObject] {
        let data: [DogObject] = FetchDogsModelUseCaseStub.response ?? []
        if let error = FetchDogsModelUseCaseStub.error {
            throw error
        }
        return data
    }
}
