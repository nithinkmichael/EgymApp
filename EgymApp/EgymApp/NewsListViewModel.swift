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

}

final class NewsListViewModel {
    private let dispatchGroup = DispatchGroup()

    let title: String

    weak var delegate: NewsListViewDelegate?

    init(
        title: String = "Top Stories"
    ) {
        self.title = title
    }
}

extension NewsListViewModel: NewsListViewModelProtocol {
    func refresh() {
        
        delegate?.willRefreshData()
        fetchData()
    }

    func fetchData() {
        delegate?.didStartFetchingData()
  

        dispatchGroup.notify(
            queue: .main,
            work: DispatchWorkItem(block: {
                self.delegate?.didFinishFetchingData()
            })
        )
    }

    func numberOfItems() -> Int {
        10
    }

    func newsListCellViewModelAt(_ index: Int) -> NewsListCellViewModel {

        return NewsListCellViewModel(title: "test",imageUrl: "",author: "nithin")
    }
}
