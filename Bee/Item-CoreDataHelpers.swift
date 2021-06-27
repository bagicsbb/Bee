//
//  Item-CoreDataHelpers.swift
//  Bee
//
//  Created by Macbook Pro CTO on 2021. 06. 24..
//

import Foundation
import CoreData

extension Item {
    var itemTitle: String {
        title ?? ""
    }
    var itemDetail: String {
        detail ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        
        return item
    }
}

