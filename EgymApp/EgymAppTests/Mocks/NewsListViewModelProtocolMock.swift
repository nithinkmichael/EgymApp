//
//  NewsListViewModelProtocolMock.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp
import Foundation

class NewsListViewModelProtocolMock: NewsListViewModelProtocol {

    
    var delegate: NewsListViewDelegate?
    var title: String {
        get { return underlyingTitle }
        set(value) { underlyingTitle = value }
    }
    var underlyingTitle: String!

    var fetchDataCallsCount = 0
    var numberOfItemsCallsCount = 0
    var numberOfItemsReturnValue: Int!
    var refreshCallsCount = 0
    var newsListCellViewModelAtCallsCount = 0
    var newsListCellViewModelAtReceivedIndex: [Int] = []
    var newsListCellViewModelAtReturnValue: NewsListCellViewModel!
    var newsDetailsViewModelAtCallsCount = 0
    var newsDetailsViewModelAtReceivedIndex: [Int] = []
    var newsDetailsViewModelAtReturnValue: NewsDetailViewModel!

    func fetchData() {
        fetchDataCallsCount += 1
    }

    func numberOfItems() -> Int {
        numberOfItemsCallsCount += 1
        return numberOfItemsReturnValue
    }

    func refresh() {
        refreshCallsCount += 1
    }
    
    func newsListCellViewModelAt(_ index: Int) -> NewsListCellViewModel {
        
        newsListCellViewModelAtCallsCount += 1
        newsListCellViewModelAtReceivedIndex.append(index)
        return newsListCellViewModelAtReturnValue
    }
    
    func newsDetailViewModelAt(_ index: Int) -> NewsDetailViewModel {
        
        newsDetailsViewModelAtCallsCount += 1
        newsDetailsViewModelAtReceivedIndex.append(index)
        return newsDetailsViewModelAtReturnValue
    }
}
