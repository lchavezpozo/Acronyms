//
//  AcromineApi.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 1/04/21.
//

import Foundation
import Moya

enum AcromineAPI: TargetType {

    case search(type: String, text: String)

    var baseURL: URL {
        return URL(string: "http://www.nactem.ac.uk/")!
    }

    var path: String {
        switch self {
        case .search: return "software/acromine/dictionary.py"
        }
    }

    var method: Moya.Method {
        switch self {
        case .search: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .search(let type, let text) : return .requestParameters(parameters: [type : text], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

}
