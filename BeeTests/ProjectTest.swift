//
//  ProjectTest.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 07. 05..
//
import CoreData
import XCTest
@testable import Bee

class ProjectTest: BaseTestCase {

    func testCreatingProjectsAndItems() {
        let targetCount = 10

        for _ in 0..<targetCount {
            let project = Project(context: managedObjectContext)

            for _ in 0..<targetCount {
                let item = Item(context: managedObjectContext)
                item.project = project
            }
        }
        XCTAssertEqual(datacontroller.count(for: Project.fetchRequest()), targetCount)
        XCTAssertEqual(datacontroller.count(for: Item.fetchRequest()), targetCount * targetCount)
    }
    
    func testDeletingProjectCascadeDeleteItems() throws {
        try datacontroller.createSampleData()
        
        let request = NSFetchRequest<Project>(entityName: "Project")
        let project = try managedObjectContext.fetch(request)
        
        datacontroller.delete(project[0])
        
        XCTAssertEqual(datacontroller.count(for: Project.fetchRequest()), 4)
        XCTAssertEqual(datacontroller.count(for: Item.fetchRequest()), 40)
    }
}
