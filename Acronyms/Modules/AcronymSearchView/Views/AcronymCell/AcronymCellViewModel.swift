//
//  AcronymCellViewModel.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

class AcronymCellViewModel {

    private var acronymLongform: AcronymLongform

    var name: String {
        return "fullform: \(acronymLongform.fullForm)"
    }

    var frequency: String {
        return "frequency: \(acronymLongform.frequency)"
    }

    var since: String {
        return "since: \(acronymLongform.since)"
    }

    init(acronymLongform: AcronymLongform) {
        self.acronymLongform = acronymLongform
    }

}
