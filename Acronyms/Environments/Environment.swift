//
//  Environment.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import Foundation

enum Environment {

    enum URL: String {
        case baseURL = "BASE_URL"
        case devURL = "DEV_URL"
        case prodURL = "PROD_URL"
        case mockURL = "MOCK_URL"
    }

    enum Bool: String {
        case enableChangeEnvironmentSettings = "ENABLE_CHANGE_ENVIRONMENT_SETTING"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        guard let environmentVariable =  dict["EnvironmentVariables"] as? [String: Any] else {
            fatalError("Plist file EnvironmentVariable not found")
        }
        return environmentVariable
    }()

}

extension Environment.URL {
    var value: URL {
        switch self {
        case .baseURL: return baseURLValidateSettings()
        default:
            guard let rootURLstring = Environment.infoDictionary[rawValue] as? String else {
                fatalError("\(rawValue) not set in plist for this environment")
            }
            guard let url = URL(string: rootURLstring) else {
                fatalError("\(rawValue) is invalid")
            }
            return url
        }
    }

    private func baseURLValidateSettings()->URL {
        guard let urlString = Environment.infoDictionary[rawValue] as? String
        else {
            fatalError("\(rawValue) not set in plist for this environment")
        }
        guard let url = URL(string: urlString) else {
            fatalError("\(rawValue) is invalid")
        }
        guard Environment.Bool.enableChangeEnvironmentSettings.value else {
            return url
        }
        let setting = Settings.get()
        return setting.baseURL
    }
}

extension Environment.Bool {
    var value : Bool {
        guard let valueString = Environment.infoDictionary[rawValue] as? String,
            let value = Bool(valueString)  else {
                fatalError("\(rawValue) not set in plist for this environment")
        }
        return value
    }
}
