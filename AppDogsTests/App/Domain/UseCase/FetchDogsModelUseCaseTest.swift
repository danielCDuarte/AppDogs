//
//  FetchDogsModelUseCaseTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs
import XCTest

class FetchDogsModelUseCaseTest: XCTestCase {
    private var persistenceRepositoriesStub: PersistenceRepositoriesStub!
    private var sut: FetchDogsModelUseCase!
   
    
    override func setUpWithError() throws {
        persistenceRepositoriesStub = PersistenceRepositoriesStub()
        sut = .init(repository: persistenceRepositoriesStub)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        PersistenceRepositoriesStub.error = nil
        PersistenceRepositoriesStub.responseSave = nil
        PersistenceRepositoriesStub.responseFetchDogModel = nil
    }
    
    func testFetchDogsModelUseCase_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectationFailure.isInverted = true
        
        PersistenceRepositoriesStub.responseFetchDogModel = TestDomainConstants.dogs
        
        //When
        do {
            let response = try await sut.execute(params: nil)
            // Then
            XCTAssertFalse(response.isEmpty)
            expectation.fulfill()
        } catch let error {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
    func testFetchDogsModelUseCase_ResponseError() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectation.isInverted = true
        
        PersistenceRepositoriesStub.error = PersistenceError.contextNotFound
        
        //When
        do {
            _ = try await sut.execute(params: nil)
            expectation.fulfill()
        } catch let error {
            // Then
            let jsonEmptyError = PersistenceError.contextNotFound.localizedDescription
            XCTAssertEqual(error.localizedDescription, jsonEmptyError)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
}
