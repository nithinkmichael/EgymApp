//
//  NewsListViewController.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet private var newsListTableView: UITableView!
    
    var viewModel: NewsListViewModelProtocol = NewsListViewModel()
    private var spinner: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


extension NewsListViewController: NewsListViewDelegate {
    func didFinishFetchingDataWith(_ error: Error) {
        let alertViewController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        present(alertViewController, animated: true)
    }

    func didFinishFetchingData() {
        self.spinner?.stopAnimating()
        self.spinner?.removeFromSuperview()
        view.isUserInteractionEnabled = true
        newsListTableView.refreshControl?.endRefreshing()
        newsListTableView.reloadData()
    }

    func didStartFetchingData() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.spinner = activityIndicator
        view.isUserInteractionEnabled = false
    }

    func willRefreshData() {
        newsListTableView.reloadData()
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell") as? NewsListTableViewCell else {
            #if DEBUG
                fatalError("Unable to find cell with identifier NewsListTableViewCell")
            #else
                return UITableViewCell()
            #endif
        }

        let cellViewModel = viewModel.newsListCellViewModelAt(indexPath.row)
        cell.configureViewWith(cellViewModel)

        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
