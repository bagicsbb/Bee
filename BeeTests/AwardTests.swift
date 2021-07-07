//
//  AwardTests.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 07. 07..
//

import XCTest
import CoreData
@testable import Bee
class AwardTests: BaseTestCase {
    let awards = Award.allAwards
    
    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }
    
    func testNoAwardsAtBeginning() {
        for award in awards {
            XCTAssertFalse(datacontroller.hasEarned(award: award), "New users should have no earned awards.")
        }
    }
    
    func testAddingItems() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        
        for (count, value) in values.enumerated() {
            var items = [Item]()
            
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
               items.append(item)
            }
            
            let matches = awards.filter { award in
                award.criterion == "items" && datacontroller.hasEarned(award: award)
            }
            
            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1) awards.")
            
            for item in items {
                datacontroller.delete(item)
            }
        }
    }
    
    func testCompletingItems() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        
        for (count, value) in values.enumerated() {
            var items = [Item]()
            
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
               items.append(item)
            }
            
            let matches = awards.filter { award in
                award.criterion == "complete" && datacontroller.hasEarned(award: award)
            }
            
            XCTAssertEqual(matches.count, count + 1, "Completing \(value) items should unlock \(count + 1) awards.")
            
            for item in items {
                datacontroller.delete(item)
            }
        }
    }


}
