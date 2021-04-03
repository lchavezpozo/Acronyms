//
//  AcronymCellViewModelTest.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import XCTest
import Moya
@testable import Acronyms

class AcronymCellViewModelTest: XCTestCase {

    var acronymLongform: AcronymLongform?
    var sut: AcronymCellViewModel?
    
    override func setUp() {
        let acronymLongform = AcronymLongform(fullForm: "test", frequency: 1, since: 1900)
        self.acronymLongform =  acronymLongform
        sut = AcronymCellViewModel(acronymLongform: acronymLongform)
    }
    
    func testCorrectTitlesForAcronymCellView() throws {
        let name = try XCTUnwrap(sut?.name)
        let frequency = try XCTUnwrap(sut?.frequency)
        let since = try XCTUnwrap(sut?.since)
        
        let desirableName = "fullform: test"
        let desirableFrequency = "frequency: 1"
        let desirableSince = "since: 1900"
        
        XCTAssertEqual(name, desirableName)
        XCTAssertEqual(frequency, desirableFrequency)
        XCTAssertEqual(since, desirableSince)
    }
}

