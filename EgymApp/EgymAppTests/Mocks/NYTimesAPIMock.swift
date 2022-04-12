//
//  NYTimesAPIMock.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import Foundation

class NYTimesAPIMock: NYTimesAPIService {


    var fetchNewsCompletionCallsCount = 0
    var fetchNewsCompletionReceivedCompletion: [ (NetworkResult<NewsData>) -> Void] = []

    func fetchNews(completion: @escaping (NetworkResult<NewsData>) -> Void) {
        fetchNewsCompletionCallsCount += 1
        fetchNewsCompletionReceivedCompletion.append(completion)
    }
    
}
