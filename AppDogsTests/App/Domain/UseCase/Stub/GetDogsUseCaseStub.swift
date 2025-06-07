//
//  GetDogsUseCaseStub.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
@testable import AppDogs

class GetDogsUseCaseStub: AnyUseCase< Any?, [DogObject]> {
    static var error: Error?
    static var response: [DogObject]!
    
    override func execute(params: Any?) async throws -> [DogObject] {
        let data: [DogObject] = GetDogsUseCaseStub.response ?? []
        if let error = GetDogsUseCaseStub.error {
            throw error
        }
        return data
    }
}
