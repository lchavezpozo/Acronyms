//
//  Array+Ext.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import Foundation

public extension Array {

    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }

}
