//
//  PersistenceRepositoriesTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
import XCTest
import Combine

@testable import AppDogs

final class PersistenceRepositoriesTest: XCTestCase {
    private var cancellable: AnyCancellable?
    private var persistenceService: PersistenceServiceType!
    private var sut: PersistenceRepositoriesType!
    
    override func setUp() {
        super.setUp()
        persistenceService = PersistenceServiceMock()
        sut = PersistenceRepositories(persistenceService: persistenceService)
    }
    
    override func tearDown() {
        PersistenceServiceMock.response = nil
        PersistenceServiceMock.error = nil
        sut = nil
        cancellable = nil
        super.tearDown()
    }
    
    func testPersistenceRepositories_whenSaveDogModel_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume persistence Service Response Expectation")
        expectationFailure.isInverted = true
        
        //When
        do {
            // then
           try await sut.save(dog: TestDataConstants.dogModel)
            successExpectation.fulfill()
            
        } catch {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, successExpectation], timeout: 1.0)
    }
    
    func testPersistenceRepositories_whenSaveDogModel_ResponseFailure() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = expectation(description: "Consume persistence Service Response Expectation")
        expectation.isInverted = true
        PersistenceServiceMock.error = NetworkError.emptyJson
        
        //When
        do {
            try await sut.save(dog: TestDataConstants.dogModel)
            expectation.fulfill()
        } catch let error {
            // then
            XCTAssertEqual(error.localizedDescription, NetworkError.emptyJson.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
    func testPersistenceRepositories_whenFetchDogModel_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume persistence Service Response Expectation")
        expectationFailure.isInverted = true
        
        PersistenceServiceMock.response = TestDataConstants.dogsModel as [Any]
        
        //When
        do {
            // then
            let response = try await sut.fetchDogs()
            XCTAssertNotNil(response)
            successExpectation.fulfill()
            
        } catch {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, successExpectation], timeout: 1.0)
    }
    
    func testPersistenceRepositorieswhenFetchDogModels_ResponseFailureEmpty() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = expectation(description: "Consume persistence Service Response Expectation")
        expectation.isInverted = true
        PersistenceServiceMock.response = [] as [Any]
        PersistenceServiceMock.error = PersistenceError.itemNotFound
        //When
        do {
            _ = try await sut.fetchDogs()
            expectation.fulfill()
        } catch let error {
            // then
            XCTAssertEqual(error.localizedDescription, PersistenceError.itemNotFound.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
}
