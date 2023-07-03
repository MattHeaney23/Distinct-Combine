//
//  DistinctTests.swift
//  DistinctTests
//
//  Created by Matt Heaney on 03/07/2023.
//

@testable import Distinct
import Combine
import XCTest

final class DistinctTests: XCTestCase {
    
    func testIntArray() {
        //Given
        let startingValues = [1, 2, 3, 4, 1, 4, 5, 5, 5]
        let publisher = DistinctPublisher(valuesToEmit: startingValues)
        var valuesEmitted: [Int] = []
        let distinctValues = [1, 2, 3, 4, 5]
        
        //When
        let expectation = XCTestExpectation()
        
        let sub = DistinctSubscriber { completion in
            expectation.fulfill()
        } onReceived: { value in
            valuesEmitted.append(value)
        }
        
        publisher.subscribe(sub)

        // Then
        wait(for: [expectation], timeout: 0.2)
        
        XCTAssertEqual(valuesEmitted, distinctValues)
    }
    
    func testEmptyArray() {
        //Given
        let startingValues: [Int] = []
        let publisher = DistinctPublisher(valuesToEmit: startingValues)
        var valuesEmitted: [Int] = []
        let distinctValues: [Int] = []
        
        //When
        let expectation = XCTestExpectation()
        
        let sub = DistinctSubscriber { completion in
            expectation.fulfill()
        } onReceived: { value in
            valuesEmitted.append(value)
        }
        
        publisher.subscribe(sub)

        // Then
        wait(for: [expectation], timeout: 0.2)
        
        XCTAssertEqual(valuesEmitted, distinctValues)
    }
}
