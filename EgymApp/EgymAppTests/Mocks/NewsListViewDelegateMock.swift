//
//  NewsListViewDelegateMock.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import Foundation

class NewsListViewDelegateMock: NewsListViewDelegate {

    var didFinishFetchingDataCallsCount = 0
    var didStartFetchingDataCallsCount = 0
    var willRefreshDataCallsCount = 0
    var didFinishFetchingDataWithCallsCount = 0
    var didFinishFetchingDataWithReceivedError: [Error] = []

    func didFinishFetchingData() {
        didFinishFetchingDataCallsCount += 1
    }

    func didStartFetchingData() {
        didStartFetchingDataCallsCount += 1
    }

    func willRefreshData() {
        willRefreshDataCallsCount += 1
    }

    func didFinishFetchingDataWith(_ error: Error) {
        didFinishFetchingDataWithCallsCount += 1
        didFinishFetchingDataWithReceivedError.append(error)
    }
}
