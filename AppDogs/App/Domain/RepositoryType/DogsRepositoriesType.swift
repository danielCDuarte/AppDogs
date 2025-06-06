//
//  DogsRepositoriesType.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

protocol DogsRepositoriesType {
    func getDogs() async throws -> [DogObject]
}
