//
//  CellProtocol.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation

protocol CellProtocol {
    static var identifier: String { get }
}

extension CellProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

