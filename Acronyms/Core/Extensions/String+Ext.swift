//
//  String+Ext.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
    
    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized, arguments: arguments)
    }

    var isEmptyOrWhiteSpaces: Bool {
        guard  !self.isEmpty else { return true }
        return self.trimmingCharacters(in: .whitespaces) == ""
    }

}
