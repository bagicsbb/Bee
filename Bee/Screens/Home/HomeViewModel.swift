//
//  HomeViewModel.swift
//  Bee
//
//  Created by Macbook Pro CTO on 2021. 08. 10..
//

import CoreData
import Foundation

extension HomeView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        private let projectsController: NSFetchedResultsController<Project>
        private let itemssController: NSFetchedResultsController<Item>
        
        @Published var projects = [Project]()
        @Published var items = [Item]()
        
        var dataController: DataController
        
        var upNext: ArraySlice<Item> {
            items.prefix(3)
        }
        
        var moreToExplore: ArraySlice<Item> {
            items.dropFirst(3)
        }
        
        init(dataController: DataController) {
            self.dataController = dataController
            
            let projectRequest: NSFetchRequest<Project> = Project.fetchRequest()
            projectRequest.predicate = NSPredicate(format: "closed = false")
            projectRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.title, ascending: true)]
            
            projectsController = NSFetchedResultsController(fetchRequest: projectRequest, managedObjectContext: dataController.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
            let itemRequest: NSFetchRequest<Item> = Item.fetchRequest()
            
            let completedPredicate = NSPredicate(format: "completed = false")
            let openPredicate = NSPredicate(format: "project.closed = false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [completedPredicate, openPredicate])
            
            itemRequest.predicate = compoundPredicate
            
            itemRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Item.priority, ascending: false)
            ]
            itemRequest.fetchLimit = 10
            
            itemssController = NSFetchedResultsController(fetchRequest: itemRequest , managedObjectContext: dataController.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
            super.init()
            
            projectsController.delegate = self
            itemssController.delegate = self
            
            do {
                try projectsController.performFetch()
                try itemssController.performFetch()
                projects = projectsController.fetchedObjects ?? []
                items = itemssController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch initial data.")
            }
        }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newItems = controller.fetchedObjects as? [Item] {
                items = newItems
            } else if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
        func addSampleData() {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
}
