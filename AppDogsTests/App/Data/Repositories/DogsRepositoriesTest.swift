//
//  DogsRepositoriesTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

import Foundation
import XCTest

@testable import AppDogs

final class DogsRepositoriesTest: XCTestCase {
    private var networkService: NetworkServiceType!
    private var sut: DogsRepositories!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        sut = DogsRepositories(networkService: networkService)
    }
    
    override func tearDown() {
        NetworkServiceMock.response = nil
        NetworkServiceMock.error = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetDogsRepository_ResponseSuccess() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        NetworkServiceMock.response = TestDataConstants.dogsResponse as AnyObject
        
        //When
        do {
            // then
            let response = try await sut.getDogs()
            XCTAssertNotNil(response)
            successExpectation.fulfill()
            
        } catch {
            XCTFail(error.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, successExpectation], timeout: 1.0)
    }
    
    func testGetDogsRepository_ResponseFailure() async {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        NetworkServiceMock.response = TestDataConstants.dogsResponse as AnyObject
        NetworkServiceMock.error = NetworkError.emptyJson
        
        //When
        do {
            _ = try await sut.getDogs()
            expectation.fulfill()
        } catch let error {
            // then
            XCTAssertEqual(error.localizedDescription, NetworkError.emptyJson.localizedDescription)
            expectationFailure.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
    
}
