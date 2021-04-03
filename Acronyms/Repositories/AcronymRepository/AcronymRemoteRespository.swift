//
//  AcronymRemoteRespository.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import Foundation

class AcronymRemoteRespository: AcronymRepository {

    private var provider: AcromineProvider

    init(provider: AcromineProvider) {
        self.provider = provider
    }

    func search(text: String, completion: @escaping ((Result<[AcronymSearchResult], NetworkingErrors>) -> Void)) {
        provider.requestDecodable(endpoint: .search(type: "sf", text: text)) { (result: Result<[AcronymSearchResult], NetworkingErrors>) in
           completion(result)
        }
    }
    
    func cancelLastRequest() {
        provider.cancelLastRequest()
    }
}
