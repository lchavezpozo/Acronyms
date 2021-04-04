//
//  AcronymSearchViewModelTest.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import XCTest
import Moya
@testable import Acronyms

class AcronymSearchViewModelTest: XCTestCase {

    var sut: AcronymSearchViewModel?
    var searchBarViewModel: SearchBarViewModel?
    var repository: AcronymMockRepository?

    override  func setUp() {
        searchBarViewModel = SearchBarViewModel(validation: .whitoutSpaces)
        repository = AcronymMockRepository()
        sut = AcronymSearchViewModel(repository: repository!, searchBarViewModel: searchBarViewModel!)
    }

    override func tearDown() {
        sut = nil
        searchBarViewModel = nil
        repository = nil
    }

    func testAcronymSearchWhenTextHasOneCharacterThenDontCallServiceAndRemoveAcronymSearchResult() throws {
        var isStartLoading = false
        repository?.searchResult = .success([])
        sut?.didStartLoading = { isStartLoading = true }
        sut?.search(text: "T")
        let totalAcronyms = try XCTUnwrap(sut?.totalAcronyms)
        XCTAssertFalse(isStartLoading)
        XCTAssertTrue(totalAcronyms == 0)
    }

    func testAcronymSearchWithEmptyTextThenDontCallServiceAndRemoveAcronymSearchResult() throws {
        var isStartLoading = false
        repository?.searchResult = .success([])
        sut?.didStopLoading = { isStartLoading = true }
        sut?.search(text: "")
        let totalAcronyms = try XCTUnwrap(sut?.totalAcronyms)
        XCTAssertFalse(isStartLoading)
        XCTAssertTrue(totalAcronyms == 0)
    }
    
    func testAcronymSearchWhenTextHasTwoCharacterThenCallService() throws {
        var isStartLoading = false
        let acronymLongform = AcronymLongform(fullForm: "Test Full form1", frequency: 1, since: 1990)
        let acronymSearchResult = AcronymSearchResult(abbreviation: "Test", coincidences: [acronymLongform])
        repository?.searchResult = .success([acronymSearchResult])
        sut?.didStartLoading = { isStartLoading = true }
        sut?.search(text: "TT")
        let totalAcronyms = try XCTUnwrap(sut?.totalAcronyms)
        XCTAssertTrue(isStartLoading)
        XCTAssertTrue(totalAcronyms > 0)
    }
    
    func testAcronymSearchWhenIsSuccessWithDataThenReloadData() {
        var isReloadData = false
        let acronymLongform = AcronymLongform(fullForm: "Test Full form1", frequency: 1, since: 1990)
        let acronymSearchResult = AcronymSearchResult(abbreviation: "Test", coincidences: [acronymLongform])
        repository?.searchResult = .success([acronymSearchResult])
        sut?.didReloadData = { isReloadData = true }
        sut?.search(text: "TEST")
        XCTAssertTrue(isReloadData)
    }
    
    func testAcronymSearchWhenIsSuccessWithEmptyDataThenShowEmptyData() {
        var isEmptyData = false
        repository?.searchResult = .success([])
        sut?.didShowEmptyData = {  isEmptyData = true  }
        sut?.search(text: "TEST")
        XCTAssertTrue(isEmptyData)
    }
    
    func testAcronymSearchWhenIsFailureWithNoInternetConnectionThenShowNoInternetConnection() throws {
        var errorResult: NetworkingErrors?
    
        repository?.searchResult = .failure(.noInternetConnection)
        sut?.didRequestFailure = { networkingError in
            errorResult = networkingError
        }
        sut?.search(text: "TEST")
        let errorResultUnWrapper = try XCTUnwrap(errorResult)
        XCTAssertTrue(errorResultUnWrapper == .noInternetConnection)
    }
    
    func testAcronymSearchWhenIsFailureWithReturnedErrorThenShowRequestFailureWithError() throws {
        var errorResult: NetworkingErrors?
        let error = NSError(domain: "test", code: 1, userInfo: nil)
        repository?.searchResult = .failure(.returnedError(error))
        sut?.didRequestFailure = { networkingError in
            errorResult = networkingError
        }
        sut?.search(text: "TEST")
        let errorResultUnWrapper = try XCTUnwrap(errorResult)
        XCTAssertTrue(errorResultUnWrapper == .returnedError(error))
    }
    
    func testAcronymSearchWhenCancelRequestThenFailureReqyest() throws {
        var errorResult: NetworkingErrors?
        repository?.searchResult = .failure(.requestCanceled)
        sut?.didRequestFailure = { networkingError in
            errorResult = networkingError
        }
        sut?.search(text: "TEST")
        let errorResultUnWrapper = try XCTUnwrap(errorResult)
        XCTAssertTrue(errorResultUnWrapper == .requestCanceled)
    }
    
    func testGetCellViewModelForWhenSendRowThenReturnAcronymCellViewModel() {
        let acronymLongform = AcronymLongform(fullForm: "Test Full form1", frequency: 1, since: 1990)
        let acronymSearchResult = AcronymSearchResult(abbreviation: "Test", coincidences: [acronymLongform])
        repository?.searchResult = .success([acronymSearchResult])
        sut?.search(text: "TEST")
        let acronymCellViewModel = sut?.getCellViewModelFor(row: 0)
        XCTAssertNotNil(acronymCellViewModel)
    }

}
