//
//  AcronymRepository.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

protocol AcronymRepository {
    func search(text: String, completion: @escaping ((Result<AcronymSearchResult, NetworkingErrors>)->Void))
    func cancelLastRequest()
}
