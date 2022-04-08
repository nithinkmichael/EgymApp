//
//  NetworkService.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import Foundation

enum NetworkResult<Value: Decodable> {
    case success(Value)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case invalidRequest
    case requestFailed
    case jsonConversionFailed
    case customError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .requestFailed:
            return "Request Failed"
        case .jsonConversionFailed:
            return "JSON Conversion Failed"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}

/// Network service Protocol which network service should be implemented
protocol NetworkService {
    /// Execute Request and returns  response in completion
    /// - Parameters:
    ///     - urlRequest:  request to be executed
    ///     - forceRefresh:  if it is `true` fresh data will be fetched from server. If it is `false` cached data will be used
    ///     - completion: request response in form of `.success(Response)` and `.failure(Error)`
    func execute<T: Decodable>(
        urlRequest: URLRequest,
        forceRefresh: Bool,
        completion: @escaping(NetworkResult<T>) -> Void
    )
}

final class NetworkManager {
    private let session: URLSession

    private let cache = URLCache(memoryCapacity: 0, diskCapacity: 1024 * 1024)

    init(
        session: URLSession = URLSession(
            configuration: .ephemeral,
            delegate: nil,
            delegateQueue: nil
        )
    ) {
        self.session = session
    }
}

extension NetworkManager: NetworkService {
    func execute<T: Decodable>(
        urlRequest: URLRequest,
        forceRefresh: Bool,
        completion: @escaping(NetworkResult<T>) -> Void
    ) {

        if !forceRefresh, let cachedResponse = cache.cachedResponse(for: urlRequest) {
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: cachedResponse.data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.jsonConversionFailed))
            }
        } else {
            let task = session.dataTask(with: urlRequest) { data, response , error in
                if let error = error {
                    completion(.failure(NetworkError.customError(error)))
                } else if let data = data {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        if let response = response {
                            let cachedData = CachedURLResponse(response: response, data: data)
                            self.cache.storeCachedResponse(cachedData, for: urlRequest)
                        }
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(.jsonConversionFailed))
                    }
                } else {
                    completion(.failure(.requestFailed))
                }
            }
            task.resume()
        }
    }
}
