//
//  XCTestCase+Ext.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import XCTest

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration)
    }
}
