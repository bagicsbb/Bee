//
//  Sequence-Sorting.swift
//  Bee
//
//  Created by Macbook Pro CTO on 2021. 06. 27..
//

import Foundation

extension Sequence {
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted {
            $0[keyPath: keyPath] < $1[keyPath: keyPath]
        }
    }
}
