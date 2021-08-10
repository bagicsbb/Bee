//
//  PerformanceTests.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 08. 09..
//

import XCTest
@testable import Bee

class PerformanceTests: BaseTestCase {

    func testAwardCalculationPerformance() throws {
        //Create a significant amount of test data
        for _ in 1...100 {
            try datacontroller.createSampleData()
        }
        //Simulate lots of awards to check
        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the number of awards is constant. Change if you add new awards." )
        measure {
            _ = awards.filter(datacontroller.hasEarned)
        }
    }

}
