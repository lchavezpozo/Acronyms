//
//  AcronymSearchResult.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import Foundation

struct AcronymSearchResult: Decodable {

    var abbreviation: String
    var coincidences: [AcronymLongform]
    
    private enum CodingKeys: String, CodingKey {
        case abbreviation = "sf"
        case coincidences = "lfs"
    }

}
