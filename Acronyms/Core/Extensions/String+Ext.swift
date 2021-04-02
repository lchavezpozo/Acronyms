//
//  String+Ext.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

extension String {

    var isEmptyOrWhiteSpaces: Bool {
        guard  !self.isEmpty else { return true }
        return self.trimmingCharacters(in: .whitespaces) == ""
    }

}

extension Optional where Wrapped == String {

    var isEmptyOrWhiteSpaces: Bool {
        guard let this = self else { return true}
        guard  !this.isEmpty else { return true }
        return this.trimmingCharacters(in: .whitespaces) == ""
    }

}
