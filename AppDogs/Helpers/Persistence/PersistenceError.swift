//
//  PersistenceError.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

enum PersistenceError: Error, LocalizedError {
    case contextNotFound
    case itemNotFound
    case saveFailed(Error)
    case fetchFailed(Error)
    case deleteFailed(Error)
}
