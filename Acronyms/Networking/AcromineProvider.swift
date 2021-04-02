//
//  AcromineProvider.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation
import Moya

enum NetworkingErrors: Error {
    case noInternetConnection
    case requestCanceled
    case returnedError(Error)
}

class AcromineProvider {

    private var provider: MoyaProvider<AcromineAPI>
    private var lastRequest: Cancellable?

    init(provider: MoyaProvider<AcromineAPI>) {
        self.provider = provider
    }

    @discardableResult
    func requestDecodable<T: Decodable>(endpoint: AcromineAPI, completion: @escaping(Result<T, NetworkingErrors>)->Void ) -> Cancellable {
        let requestResult = provider.request(endpoint) { (result) in
            switch result {
            case .success(let response):
                do {
                    let object = try response.map(T.self)
                    completion(.success(object))
                } catch(let error) {
                    let networkingErrors = NetworkingErrors.returnedError(error)
                    completion(.failure(networkingErrors))
                }
            case .failure(let error):
                switch error.errorCode {
                case 15, -999:
                    let networkingErrors = NetworkingErrors.requestCanceled
                    completion(.failure(networkingErrors))
            
                default:
                    let networkingErrors = NetworkingErrors.returnedError(error)
                    completion(.failure(networkingErrors))
                }
              
            }
        }
        lastRequest = requestResult
        return requestResult
    }

    func cancelLastRequest() {
        lastRequest?.cancel()
    }

}
