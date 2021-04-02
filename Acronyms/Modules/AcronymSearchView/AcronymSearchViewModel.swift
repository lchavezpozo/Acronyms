//
//  AcronymSearchViewModel.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

class AcronymSearchViewModel {

    private var repository: AcronymRepository
    private var acronymSearchResult: AcronymSearchResult?

    private var totalAcronyms: Int {
        return acronymSearchResult?.coincidences.count ?? 0
    }

    init(repository: AcronymRepository) {
        self.repository = repository
    }

    func search(text: String) {
        repository.cancelLastRequest()
        repository.search(text: text) { [weak self] (result) in
            switch result {
            case .success(let acronymSearchResult):
                self?.acronymSearchResult = acronymSearchResult
            case .failure(let netWorkingError):
                self?.handleSearchError(netWorkingError)
            }
        }
    }

    private func handleSearchError(_ error: NetworkingErrors) {
        switch error {
        case .noInternetConnection: break
        case .requestCanceled: break
        case .returnedError(let error): break
        }
    }
}
