//
//  SearchBarViewModel.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

class SearchBarViewModel {

    enum Validation {
        case whitoutSpaces
        case none
    }

    var indicatorTitleText: String?
    var placeholderText: String?
    var validation: Validation

    init(validation: Validation, placeholderText: String? = nil, indicatorTitleText: String? = nil) {
        self.validation = validation
        self.placeholderText = placeholderText
        self.indicatorTitleText = indicatorTitleText
    }

    func validationChange(text: String)-> Bool {
        switch validation {
        case .whitoutSpaces: return !text.isEmptyOrWhiteSpaces
        case .none: return true
        }
    }

}
