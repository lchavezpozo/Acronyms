//
//  AcronymRemoteRepositoryTest.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import XCTest
import Moya
@testable import Acronyms

class AcronymRemoteRepositoryTest: XCTestCase {
    
    func testAcronymSearhWithStatusCode200AndDataThenRequestSuccess() {
    
        let sut = getSut(statusCode: 200, mockDatafileName: "AcronymSearchResultSuccess")
        var isSuccess = false
        sut.search(text: "Test") { (result) in
            switch result {
            case .success: isSuccess = true
            case .failure: isSuccess = false
            }
        }
        XCTAssertTrue(isSuccess)
    }
    
    func testAcronymSearhWithStatusCode200AndErrorFieldsThenRequesFailureForDecodableError() {
    
        let sut = getSut(statusCode: 200, mockDatafileName: "AcronymSearchResultSuccessWithFieldError")
        var isFailure = false
        sut.search(text: "Test") { (result) in
            switch result {
            case .success: isFailure = false
            case .failure: isFailure = true
            }
        }
        XCTAssertTrue(isFailure)
    }

    func testAcronymSearhWithStatusCode400ThenRequestFailure() {
    
        let sut = getSut(statusCode: 400, mockDatafileName: "")
        var isFailure = false
        sut.search(text: "Test") { (result) in
            switch result {
            case .success: isFailure = false
            case .failure: isFailure = true
            }
        }
        XCTAssertTrue(isFailure)
    }

    func getSut(statusCode: Int, mockDatafileName: String)-> AcronymRemoteRespository {
        let  moyaProvider = MoyaProvider<AcromineAPI>(endpointClosure: MockEndpointClousure.sampleData(statusCode, mockDatafileName).endpoint, stubClosure: MoyaProvider.immediatelyStub)
        let provider = AcromineProvider(provider:  moyaProvider)
        let sut = AcronymRemoteRespository(provider: provider)
        return sut
    }
    
}
