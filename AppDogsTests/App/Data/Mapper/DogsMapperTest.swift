//
//  DogsMapperTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs
import XCTest

class DogsMapperTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testDogsMapper_WhenInputIsFilled_ThenReturnObjectFilled() throws {
        // Given
        let input = TestDataConstants.dogsResponse
        // when
        let result = DogsMapper.map(input: input)
        // then
        XCTAssertEqual(result.count, input.count)
    }
}
