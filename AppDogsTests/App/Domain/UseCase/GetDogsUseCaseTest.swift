//
//  GetDogsUseCaseTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs
import XCTest

class GetDogsUseCaseTest: XCTestCase {
    private var dogsRepositoriesStub: DogsRepositoriesStub!
    private var sut: GetDogsUseCase!
   
    
    override func setUpWithError() throws {
        dogsRepositoriesStub = DogsRepositoriesStub()
        sut = .init(repository: dogsRepositoriesStub)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        DogsRepositoriesStub.error = nil
        DogsRepositoriesStub.response = nil
    }
    
    func testGetDogsUseCase_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectationFailure.isInverted = true
        
        DogsRepositoriesStub.response = TestDomainConstants.dogs
        
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
    
    func testGetDogsUseCase_ResponseError() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectation.isInverted = true
        
        DogsRepositoriesStub.error = NetworkError.emptyJson
        
        //When
        do {
            _ = try await sut.execute(params: nil)
            expectation.fulfill()
        } catch let error {
            // Then
            let jsonEmptyError = NetworkError.emptyJson.localizedDescription
            XCTAssertEqual(error.localizedDescription, jsonEmptyError)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
}
