//
//  AcronymSearchViewModel.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

class AcronymSearchViewModel {

    private var repository: AcronymRepository
    private (set) var searchBarViewModel: SearchBarViewModel

    private var acronymSearchResult: AcronymSearchResult?
    private let minCharacterForSearching = 2

    var totalAcronyms: Int {
        return acronymSearchResult?.coincidences.count ?? 0
    }

    var didReloadData: (()->Void)?
    var didStartLoading: (()->Void)?
    var didStopLoading: (()->Void)?
    var didRequestFailure: ((NetworkingErrors)->Void)?
    var didShowEmptyData: (()->Void)?

    init(repository: AcronymRepository, searchBarViewModel: SearchBarViewModel) {
        self.repository = repository
        self.searchBarViewModel = searchBarViewModel
    }

    func search(text: String) {
        repository.cancelLastRequest()
        guard validateMinCharacterForSearching(text) else {
            removeAcronymSearchResult()
            return
        }
        didStartLoading?()
        repository.search(text: text) { [weak self] (result) in
            switch result {
            case .success(let acronymSearchResults):
                self?.acronymSearchResult = acronymSearchResults.first
                self?.didReloadData?()
                self?.validateEmptyData(acronymSearchResults)
            case .failure(let netWorkingError):
                self?.didRequestFailure?(netWorkingError)
                self?.removeAcronymSearchResult()
            }
            self?.didStopLoading?()
        }
    }

    private func validateMinCharacterForSearching(_ text: String)-> Bool{
        return text.count >= minCharacterForSearching
    }

    private func removeAcronymSearchResult() {
        acronymSearchResult = nil
        didReloadData?()
    }

    private func validateEmptyData(_ acronymSearchResults: [AcronymSearchResult]) {
        if acronymSearchResults.isEmpty {
            didShowEmptyData?()
        }
    }

    func getCellViewModelFor(row: Int)-> AcronymCellViewModel? {
        guard let acronym = acronymSearchResult?.coincidences[safe: row] else { return nil}
        let viewModel = AcronymCellViewModel(acronymLongform: acronym)
        return viewModel
    }

}
