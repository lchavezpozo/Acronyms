//
//  AcromineProvider.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 2/04/21.
//

import Foundation
import Moya
import Alamofire

enum NetworkingErrors: Error, Equatable {

    case noInternetConnection
    case requestCanceled
    case returnedError(Error)

    static func == (lhs: NetworkingErrors, rhs: NetworkingErrors) -> Bool {
        switch (lhs , rhs) {
        case (.noInternetConnection, .noInternetConnection): return true
        case (.requestCanceled, .requestCanceled): return true
        case (.returnedError, .returnedError): return true
        default: return false
        }
    }

}

class AcromineProvider {

    private var provider: MoyaProvider<AcromineAPI>
    private var lastRequest: Cancellable?

    init(provider: MoyaProvider<AcromineAPI>) {
        self.provider = provider
    }

    @discardableResult
    func requestDecodable<T: Decodable>(endpoint: AcromineAPI, completion: @escaping(Result<T, NetworkingErrors>)->Void ) -> Cancellable {
        let requestResult = provider.request(endpoint) { [weak self] (result) in
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
                self?.handleMoyaError(error, completion: completion)
            }
        }
        lastRequest = requestResult
        return requestResult
    }

    private func handleMoyaError<T: Decodable>(_ moyaError: MoyaError, completion: @escaping(Result<T, NetworkingErrors>)->Void )  {
        switch moyaError {
        case .underlying(let underlyingError, _):
            if  let aFError = underlyingError as? AFError {
                handleAlamofireError(error: aFError, completion: completion)
            } else {
                let networkingErrors = NetworkingErrors.returnedError(underlyingError)
                completion(.failure(networkingErrors))
            }
        default:
            let networkingErrors = NetworkingErrors.returnedError(moyaError)
            completion(.failure(networkingErrors))
        }
    }

    private func handleAlamofireError<T: Decodable>(error: AFError, completion: @escaping(Result<T, NetworkingErrors>)->Void ) {
        switch error {
        case .explicitlyCancelled:
            let networkingErrors = NetworkingErrors.requestCanceled
            completion(.failure(networkingErrors))
        default:
            let networkingErrors = NetworkingErrors.returnedError(error)
            completion(.failure(networkingErrors))
        }
    }

    func cancelLastRequest() {
        lastRequest?.cancel()
    }

}
