//
//  AppDogsApp.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import SwiftUI

@main
struct AppDogsApp: App {
    let factory = Factory(baseUrl: DataConstants.baseUrl)
    var body: some Scene {
        WindowGroup {
            SearchDogsView<SearchDogsViewModel>()
        }
    }
}
