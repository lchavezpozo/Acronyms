//
//  SearchBarViewModelTest.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import XCTest
@testable import Acronyms

class SearchBarViewModelTest: XCTestCase {
    
    var sut: SearchBarViewModel?
    
    override func setUp() {
        sut = SearchBarViewModel(validation: .whitoutSpaces)
    }
    
    func testValidationChangeWhenIsEmptyTextThenIsFalse() throws {
        let result = sut?.validationChange(text: "")
        let resultUnWrap = try XCTUnwrap(result)
        XCTAssertFalse(resultUnWrap)
    }
    
    func testValidationChangeWhenTextThenIsTrue() throws {
        let result = sut?.validationChange(text: "T")
        let resultUnWrap = try XCTUnwrap(result)
        XCTAssertTrue(resultUnWrap)
    }
    
    func testDelayTypingMilisecondFor300Miliseconds() {
        var didChangeText = ""
        sut?.didChangeText = { text in
            didChangeText = text
        }
        sut?.handleTextDidChange(text: "TEST")
        wait(for: 0.4)
        XCTAssertTrue(didChangeText == "TEST")
    }
    
    func testDelayTypingMilisecondFor0Miliseconds() {
        var didChangeText = ""
        sut?.didChangeText = { text in
            didChangeText = text
        }
        sut?.handleTextDidChange(text: "TEST")
        wait(for: 0.1)
        XCTAssertFalse(didChangeText == "TEST")
    }

}
