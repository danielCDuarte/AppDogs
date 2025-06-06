//
//  DogsModelMapperTest.swift
//  AppDogs
//
//  Created by Daniel Crespo Duarte on 6/06/25.
//

@testable import AppDogs
import XCTest

class DogsModelMapperTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testDogsModelMapper_WhenInputIsFilled_ThenReturnObjectFilled() throws {
        // Given
        let input = TestDataConstants.dogsModel
        // when
        let result = DogsModelMapper.map(input: input)
        // then
        XCTAssertEqual(result.count, input.count)
    }
}
