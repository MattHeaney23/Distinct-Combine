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
        assertDistinctSubscriberOutput(startingValues: [1, 2, 3, 4, 1, 4, 5, 5, 5],
                                       expectedOutput: [1, 2, 3, 4, 5])
    }
    
    func testStringArray() {
        assertDistinctSubscriberOutput(startingValues: ["A", "B", "C", "C", "B", "C", "D", "A", "D", "D", "E"],
                                       expectedOutput: ["A", "B", "C", "D", "E"])
    }
    
    func testSingleStringArray() {
        assertDistinctSubscriberOutput(startingValues: ["A"],
                                       expectedOutput: ["A"])
    }
    
    func testExtremeStringArray() {
        
        let lotsOfAs = [String](repeating: "A", count: 1000)
        let fewBs = [String](repeating: "B", count: 10)
        let lotsOfCs = [String](repeating: "C", count: 1000)
        
        let startingValues: [String] = lotsOfAs + fewBs + lotsOfCs
        
        assertDistinctSubscriberOutput(startingValues: startingValues,
                                       expectedOutput: ["A", "B", "C"])
    }
    
    func testEmptyArray() {
        assertDistinctSubscriberOutput(startingValues: [Int](),
                                       expectedOutput: [Int]())
    }
    
    private func assertDistinctSubscriberOutput<T: Hashable>(startingValues: [T], expectedOutput: [T]) {
        //Given
        let publisher = DistinctPublisher(valuesToEmit: startingValues)
        var valuesEmitted: [T] = []
        
        //When, and Then
        let sub = DistinctSubscriber { completion in
            XCTAssertEqual(valuesEmitted, expectedOutput)
        } onReceived: { value in
            valuesEmitted.append(value)
        }
        
        publisher.subscribe(sub)

    }
}
