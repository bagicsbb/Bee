//
//  AssetTest.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 06. 30..
//

import XCTest
@testable import Bee

class AssetTest: XCTestCase {

    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }
    
    func testJSoNLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON.")
    }

}
