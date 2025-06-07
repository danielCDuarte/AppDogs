//
//  SyncUseCaseTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs
import XCTest

class SyncUseCaseTest: XCTestCase {
    private var fetchDogsModelUseCaseStub: FetchDogsModelUseCaseStub!
    private var getDogsUseCaseStub: GetDogsUseCaseStub!
    private var saveDogModelUseCaseStub: SaveDogModelUseCaseStub!
    private var sut: SyncUseCase!
    private var userDefaultsMock: UserDefaultsMock!
    
    override func setUpWithError() throws {
        fetchDogsModelUseCaseStub = FetchDogsModelUseCaseStub()
        getDogsUseCaseStub = GetDogsUseCaseStub()
        saveDogModelUseCaseStub = SaveDogModelUseCaseStub()
        userDefaultsMock = UserDefaultsMock()
        sut = .init(
            fetchDogsModelUseCase: fetchDogsModelUseCaseStub,
            getDogsUseCase: getDogsUseCaseStub,
            saveDogModelUseCase: saveDogModelUseCaseStub,
            userDefaults: userDefaultsMock
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        FetchDogsModelUseCaseStub.error = nil
        FetchDogsModelUseCaseStub.response = nil
        GetDogsUseCaseStub.error = nil
        GetDogsUseCaseStub.response = nil
        SaveDogModelUseCaseStub.error = nil
        SaveDogModelUseCaseStub.response = nil
    }
    
    func testSyncUseCase_ResponseSuccess() async {
        // Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectationFailure.isInverted = true
        
        GetDogsUseCaseStub.response = TestDomainConstants.dogs
        FetchDogsModelUseCaseStub.response = TestDomainConstants.dogs
        SaveDogModelUseCaseStub.response = Void()
        
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
    
    func testSyncUseCase_ResponseError() async {
        // Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectation.isInverted = true
        
        GetDogsUseCaseStub.error = NetworkError.emptyJson
        FetchDogsModelUseCaseStub.response = []
        SaveDogModelUseCaseStub.response = Void()
        
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
    
    func testSyncUseCase_notFirstLaunch_ResponseSuccess() async {
        // Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectationFailure.isInverted = true
        
        userDefaultsMock.set(true, forKey: "hasLaunchedBefore")
        GetDogsUseCaseStub.response = TestDomainConstants.dogs
        FetchDogsModelUseCaseStub.response = TestDomainConstants.dogs
        SaveDogModelUseCaseStub.response = Void()
        
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
    
    func testSyncUseCase_notFirstLaunch_ResponseError() async {
        // Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume use case Response Expectation")
        expectation.isInverted = true
        
        userDefaultsMock.set(true, forKey: "hasLaunchedBefore")
        GetDogsUseCaseStub.error = NetworkError.emptyJson
        FetchDogsModelUseCaseStub.error = PersistenceError.itemNotFound
        SaveDogModelUseCaseStub.error = PersistenceError.itemNotFound
        
        //When
        do {
            _ = try await sut.execute(params: nil)
            expectation.fulfill()
        } catch let error {
            // Then
            let jsonEmptyError = PersistenceError.itemNotFound.localizedDescription
            XCTAssertEqual(error.localizedDescription, jsonEmptyError)
            expectationFailure.fulfill()
        }
        
        await fulfillment(of: [expectationFailure, expectation], timeout: 1.0)
    }
}
