//
//  Utils.swift
//  AcronymsTests
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import Foundation
import Moya
@testable import Acronyms

enum MockEndpointClousure {
    case sampleData(Int, String)
    func endpoint(_ target: AcromineAPI)-> Endpoint {
        switch self {
        case .sampleData(let statusCode, let fileName):
            let mockData = MockData()
            let data = mockData.getMockData(fileName: fileName) ?? Data()
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(statusCode, data)},
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
       
    }

}

class MockData {

     func getMockData(fileName: String)-> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }

}
