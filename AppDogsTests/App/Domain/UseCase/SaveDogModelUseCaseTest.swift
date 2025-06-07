//
//  SaveDogModelUseCaseTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs
import XCTest

class SaveDogModelUseCaseTest: XCTestCase {
    private var persistenceRepositoriesStub: PersistenceRepositoriesStub!
    private var sut: SaveDogModelUseCase!
   
    
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
    
    func testSaveDogModelUseCase_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectationFailure.isInverted = true
        
        PersistenceRepositoriesStub.responseSave = Void()
        
        //When
        do {
            try await sut.execute(params: TestDomainConstants.dog)
            // Then
            expectation.fulfill()
        } catch let error {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
    func testSaveDogModelUseCase_ResponseError() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectation.isInverted = true
        
        PersistenceRepositoriesStub.error = PersistenceError.contextNotFound
        
        //When
        do {
            _ = try await sut.execute(params: TestDomainConstants.dog)
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
