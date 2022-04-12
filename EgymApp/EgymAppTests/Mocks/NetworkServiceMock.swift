//
//  NetworkServiceMock.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import Foundation

class NetworkServiceMock: NetworkService {

    var executeUrlRequestCompletionCallsCount = 0
    var executeUrlRequestCompletionReceivedUrlRequest: [URLRequest] = []

    func execute<T>(urlRequest: URLRequest, completion: @escaping (NetworkResult<T>) -> Void) where T : Decodable {
        executeUrlRequestCompletionCallsCount += 1
        executeUrlRequestCompletionReceivedUrlRequest.append(urlRequest)
    }
}
