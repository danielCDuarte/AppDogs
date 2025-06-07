//
//  SearchDogsState.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
import SwiftUI

final class SearchDogsState: ObservableObject {
    @Published var dogs: [DogObject] = []
    @Published var searchDogs: [DogObject] = []
    @Published var isLoading: Bool = true
    @Published var numberSkeletonCell: Int = 8
    @Published var alert: Bool = false
    @Published var searchText = ""
    
    enum Constants {
        static let title = "Dogs We Love"
        static let error = "An error has occurred."
        static let errorMessage = "An error has occurred, please try again later."
        static let accept = "Ok"
    }
}
