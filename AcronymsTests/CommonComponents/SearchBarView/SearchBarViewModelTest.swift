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

}
