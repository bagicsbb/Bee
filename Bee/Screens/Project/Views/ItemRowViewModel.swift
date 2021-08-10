//
//  ItemRowViewModel.swift
//  Bee
//
//  Created by Macbook Pro CTO on 2021. 08. 10..
//

import Foundation

extension ItemRowView {
    class ViewModel: ObservableObject {
        
        let project: Project
        let item: Item
        
        var title: String {
            item.itemTitle
        }
        
        var icon: String {
            if item.completed {
                return  "checkmark.circle"
            } else if item.priority == 3 {
                return "exclamationmark.triangle"
            } else {
                return "checkmark.circle"
            }
        }
        
        var color: String? {
            if item.completed {
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return nil
            }
        }
        
        
        var label: String {
            if item.completed {
                return ("\(item.itemTitle), completed")
            } else if item.priority == 3 {
                return ("\(item.itemTitle), high priority.")
            } else {
                return ("\(item.itemTitle)")
            }
        }
        
        init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }
    }
}
