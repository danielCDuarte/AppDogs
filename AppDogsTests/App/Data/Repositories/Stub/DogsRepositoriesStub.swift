//
//  DogsRepositoriesStub.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
@testable import AppDogs

final class DogsRepositoriesStub {
    static var error: Error?
    static var response: [DogObject]!
}

extension DogsRepositoriesStub: DogsRepositoriesType {
    func getDogs() async throws -> [AppDogs.DogObject] {
        let data: [DogObject] = DogsRepositoriesStub.response ?? []
        if let error = DogsRepositoriesStub.error {
            throw error
        }
        return data
    }
}
