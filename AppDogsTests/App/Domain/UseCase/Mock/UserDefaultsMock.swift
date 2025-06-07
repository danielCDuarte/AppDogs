//
//  UserDefaultsMock.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation

class UserDefaultsMock: UserDefaults {
    private var storage = [String: Any]()
    var setValueCalled = false
    
    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
        setValueCalled = true
    }
    
    override func bool(forKey defaultName: String) -> Bool {
        storage[defaultName] as? Bool ?? false
    }
}
