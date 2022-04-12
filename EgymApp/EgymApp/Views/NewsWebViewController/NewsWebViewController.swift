//
//  NewsWebViewController.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {

    private var viewModel: NewsDetailViewModel!
    private var spinner: UIActivityIndicatorView?
    @IBOutlet weak var webView: WKWebView!

    static func viewController(
        viewModel: NewsDetailViewModel
    ) -> NewsWebViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsWebViewController") as? NewsWebViewController else {
            assertionFailure("NewsWebViewController not found")
            return UIViewController() as! NewsWebViewController
        }

        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        
        self.updateUI()
        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        let url = URL(string: viewModel.newsUrl!)!
        let urlRequest = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(urlRequest)
        
    }

    func setUpSpinnerView() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.spinner = activityIndicator
    }
    
    func removeSpinnerView() {
        self.spinner?.stopAnimating()
        self.spinner?.removeFromSuperview()
    
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }

    }
    
}

extension NewsWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
    {
          print(error.localizedDescription)
     }
     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
     {
         self.setUpSpinnerView()
     }
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
     {
         self.removeSpinnerView()
     }
}
