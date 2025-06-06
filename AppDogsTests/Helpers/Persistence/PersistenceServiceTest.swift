//
//  PersistenceServiceTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import XCTest
import SwiftData
@testable import AppDogs

class PersistenceServiceTests: XCTestCase {
    private var sut: PersistenceService!
    private var modelContainer: ModelContainer!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let schema = Schema([
            DogModel.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        modelContainer = try ModelContainer(
            for: schema,
            configurations: [modelConfiguration]
        )
        sut = PersistenceService(container: modelContainer)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        modelContainer = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests with GWT pattern
    
    func test_saveAndFetch() throws {
        // Given
        let dog = DogModel(name: "Rex", desc: "German Shepherd", age: 3, image: "rex.jpg")
        
        // When
        try sut.save(dog)
        let fetchedDogs = try sut.fetch(DogModel.self)
        
        // Then
        XCTAssertEqual(fetchedDogs.count, 1)
        XCTAssertEqual(fetchedDogs.first?.name, "Rex")
    }
    
    func test_fetchById() throws {
        // Given
        let dog = DogModel(name: "Bella", desc: "Poodle", age: 2, image: "bella.jpg")
        try sut.save(dog)
        
        // When
        let fetchedDog = try sut.fetchById(DogModel.self, id: dog.persistentModelID)
        
        // Then
        XCTAssertNotNil(fetchedDog)
        XCTAssertEqual(fetchedDog?.name, "Bella")
    }
    
    func test_updateItem() throws {
        // Given
        let dog = DogModel(name: "Luna", desc: "Labrador", age: 4, image: "luna.jpg")
        try sut.save(dog)
        dog.name = "Luna Updated"
        
        // When
        try sut.update(dog)
        let fetchedDogs = try sut.fetch(DogModel.self)
        
        // Then
        XCTAssertEqual(fetchedDogs.first?.name, "Luna Updated")
    }
    
    func test_deleteItem() throws {
        // Given
        let dog = DogModel(name: "Max", desc: "Beagle", age: 5, image: "max.jpg")
        try sut.save(dog)
        
        // When
        try sut.delete(dog)
        let fetchedDogs = try sut.fetch(DogModel.self)
        
        // Then
        XCTAssertTrue(fetchedDogs.isEmpty)
    }
    
    func test_deleteAll() throws {
        // Given
        let dog1 = DogModel(name: "Max", desc: "Beagle", age: 5, image: "max.jpg")
        let dog2 = DogModel(name: "Bella", desc: "Poodle", age: 2, image: "bella.jpg")
        try sut.save(dog1)
        try sut.save(dog2)
        
        // When
        try sut.deleteAll(DogModel.self)
        let fetchedDogs = try sut.fetch(DogModel.self)
        
        // Then
        XCTAssertTrue(fetchedDogs.isEmpty)
    }
}
