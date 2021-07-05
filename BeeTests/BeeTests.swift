//
//  BeeTests.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 06. 30..
//

import XCTest
import CoreData
@testable import Bee

class BaseTestCase: XCTestCase {
    var datacontroller: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        datacontroller = DataController(inMemory: true)
        managedObjectContext = datacontroller.container.viewContext
    }

}
