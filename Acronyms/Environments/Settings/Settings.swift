//
//  Settings.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import Foundation

enum Settings: String {

    case dev = "dev"
    case prod = "prod"
    case mock = "mock"
    case custom = "custom"

    static func get() -> Settings {
        guard let value = UserDefaults.standard.string(forKey: "environment"),
            let setting = Settings(rawValue: value) else {
            return .dev
        }
        return setting
        
    }

    var baseURL: URL {
        switch self {
        case .dev: return Environment.URL.devURL.value
        case .prod: return Environment.URL.prodURL.value
        case .mock: return Environment.URL.mockURL.value
        case .custom:
             guard let customUrlString = UserDefaults.standard.string(forKey: "customUrlTextField"),
                let customUrl = URL(string: customUrlString) else {
                    return Environment.URL.devURL.value
            }
            return customUrl
        }
    }

}
