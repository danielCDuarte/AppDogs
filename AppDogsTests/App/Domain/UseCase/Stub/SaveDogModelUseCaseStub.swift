//
//  SaveDogModelUseCaseStub.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
@testable import AppDogs

class SaveDogModelUseCaseStub: AnyUseCase< DogObject, Void> {
    static var error: Error?
    static var response: Void!
    
    override func execute(params: DogObject) async throws -> Void {
        let data: Void = SaveDogModelUseCaseStub.response ?? Void()
        if let error = SaveDogModelUseCaseStub.error {
            throw error
        }
        return data
    }
}
