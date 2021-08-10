//
//  DevelopmentTests.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 07. 07..
//

import CoreData
import XCTest
@testable import Bee

class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() throws {
        try datacontroller.createSampleData()
        
        XCTAssertEqual(datacontroller.count(for: Project.fetchRequest()), 5, "There should be 5 sample projects.")
        XCTAssertEqual(datacontroller.count(for: Item.fetchRequest()), 50, "There should be 50 sample items.")
    }
    
    func testDeleteAllClearsEverything() throws {
        try datacontroller.createSampleData()
        datacontroller.deleteAll()
        
        XCTAssertEqual(datacontroller.count(for: Project.fetchRequest()), 0)
        XCTAssertEqual(datacontroller.count(for: Item.fetchRequest()), 0)
    }
    
    func testExampleProjectIsClosed() {
        let project = Project.example
        
        XCTAssertTrue(project.closed, "The example project should be closed.")
    }
    
    func testExampleItemIsHighPriority() {
        let item = Item.example
        
        XCTAssertEqual(item.priority, 3, "The example item should be high priority.")
    }

}
