//
//  ExtensionTests.swift
//  BeeTests
//
//  Created by Macbook Pro CTO on 2021. 07. 07..
//

import SwiftUI
import XCTest
@testable import Bee

class ExtensionTests: XCTestCase {
    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)
        
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted numbers must be ascending.")
    }
    
    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }
    
    func testDecodingStrings() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        
        XCTAssertEqual(data, "The rain in Spain falls mainly on the Spaniards", "The string must match the content of DecodableString.json.")
    }
    
    func testDecodeingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(Dictionary<String, Int>.self, from: "DecodableDictionary.json")
        
        XCTAssertEqual(data.count, 3, "There should be 3 items decoded from DecodableDictionary.json")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain Int to String mappings.")
    }
    
    func testBindingOnchange() {
        //Given
        var onChangeFunctionRun = false
        
        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }
        
        var storedValue = ""
        
        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )
        
        let changedBinding = binding.onChange(exampleFunctionToCall)
        //When
        changedBinding.wrappedValue = "Test"
        
        //Then
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function must be run when the binding is changed.")
    }

}
