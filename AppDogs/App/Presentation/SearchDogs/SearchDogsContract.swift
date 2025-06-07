//
//  SearchDogsContract.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
import SwiftUI

protocol SearchDogsViewModelType: ObservableObject {
    var state: SearchDogsState { get set }
    func searchDogs(query: String)
    func onAppear()
    func onDisAppear()
}
