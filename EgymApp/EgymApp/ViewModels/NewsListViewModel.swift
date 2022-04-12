//
//  NewsListViewModel.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import Foundation

/// Inform the delegate about various events in ViewModel
protocol NewsListViewDelegate: AnyObject {
    /// Tells the delegate data fetch has been completed
    func didFinishFetchingData()

    /// Tells the delegate data fetch has started
    func didStartFetchingData()

    /// Tells the delegate view model will going to refresh the data
    ///
    ///  Al the data has been cleared
    func willRefreshData()

    /// Tells the delegate data fetch finished with error
    /// - Parameters:
    ///     - error:  error received
    func didFinishFetchingDataWith(_ error: Error)
}

/// Methods and variables which view model for NewsListView should be implemented
protocol NewsListViewModelProtocol {

    ///  Events handler delegate
    var delegate: NewsListViewDelegate? { get set }

    ///  Title
    var title: String { get }

    ///  Fetch data required for news list view
    func fetchData()

    ///  Returns number of news items
    func numberOfItems() -> Int

    ///  Method to refresh the data
    func refresh()

    /// Return ViewModel for NewsListTableViewCell
    /// - Parameters:
    ///     - index:  index of the cell
    func newsListCellViewModelAt(_ index: Int) -> NewsListCellViewModel

    /// Return ViewModel for NewsDetailViewController
    /// - Parameters:
    ///     - index:  index of the news which detail view to be shown
    func newsDetailViewModelAt(_ index: Int) -> NewsDetailViewModel
}

final class NewsListViewModel {
    private let dispatchGroup = DispatchGroup()
    private let nyTimesAPIClient: NYTimesAPIService

    let title: String

    private var news: [News] = []

    weak var delegate: NewsListViewDelegate?

    init(
        title: String = "Top Stories",
        nyTimesAPIClient: NYTimesAPIService = NYTimesAPI.shared

    ) {
        self.title = title
        self.nyTimesAPIClient = nyTimesAPIClient
    }
}

private extension NewsListViewModel {
    func itemAt(_ index: Int) -> News {
        news[index]
    }

    func imageFor(_ news: News,_ format:Format) -> Multimedia? {
        if let multimedia = news.multimedia?.filter ({ $0.format == format }).first {
            return multimedia
        }
        return nil
    }
    
    func clearData() {
        news.removeAll()
    }
}

extension NewsListViewModel: NewsListViewModelProtocol {
    func refresh() {
        
        delegate?.willRefreshData()
        fetchData()
    }

    func fetchData() {
        
        delegate?.didStartFetchingData()
        dispatchGroup.enter()
        nyTimesAPIClient.fetchNews { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .success(let newsdata):
                self?.news = newsdata.results ?? []
            case .failure(let error):
                self?.clearData()
                self?.delegate?.didFinishFetchingDataWith(error)
            }
        }

        dispatchGroup.notify(
            queue: .main,
            work: DispatchWorkItem(block: {
                self.delegate?.didFinishFetchingData()
            })
        )
    }

    func numberOfItems() -> Int {
        news.count
    }

    func newsListCellViewModelAt(_ index: Int) -> NewsListCellViewModel {

        let news = itemAt(index)
        
        let multimedia = imageFor(news, .threeByTwoSmallAt2X)

        return NewsListCellViewModel(title: news.title ,imageUrl: multimedia?.url ,author: news.byline)
    }
    
    func newsDetailViewModelAt(_ index: Int) -> NewsDetailViewModel {
        let news = itemAt(index)
        let multimedia = imageFor(news, .threeByTwoSmallAt2X)
        return NewsDetailViewModel(title: news.title, description: news.abstract, author: news.byline, imageUrl: multimedia?.url, newsUrl: news.shortURL)
    }
}
