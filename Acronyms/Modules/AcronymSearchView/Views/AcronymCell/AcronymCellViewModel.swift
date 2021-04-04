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
        return  "acronymCell.fullFormTitle".localizedFormat(acronymLongform.fullForm)
    }

    var frequency: String {
        return "acronymCell.frecuencyTitle".localizedFormat(acronymLongform.frequency)
    }

    var since: String {
        return "acronymCell.sinceTitle" .localizedFormat(acronymLongform.since)
    }

    init(acronymLongform: AcronymLongform) {
        self.acronymLongform = acronymLongform
    }

}
