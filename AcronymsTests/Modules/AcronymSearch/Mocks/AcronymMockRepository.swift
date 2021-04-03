//
//  AcronymMockRepository.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation
@testable import Acronyms

class AcronymMockRepository: AcronymRepository {

    var isCancellLastRequest = false
    var searchResult: Result<[AcronymSearchResult], NetworkingErrors> = .success([])

    func search(text: String, completion: @escaping ((Result<[AcronymSearchResult], NetworkingErrors>) -> Void)) {
        isCancellLastRequest = false
        completion(searchResult)
    }
    
    func cancelLastRequest() {
        isCancellLastRequest = true
    }

}
