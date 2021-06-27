//
//  Binding-OnChange.swift
//  Bee
//
//  Created by Macbook Pro CTO on 2021. 06. 27..
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: {self.wrappedValue},
            set: {newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
