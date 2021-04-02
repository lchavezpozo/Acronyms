//
//  AcronymLongform.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import Foundation

struct AcronymLongform: Decodable {

    var fullForm: String
    var frequency: Int
    var since: Int

    private enum CodingKeys: String, CodingKey {
        case fullForm = "lf"
        case frequency = "freq"
        case since = "since"
    }

}
