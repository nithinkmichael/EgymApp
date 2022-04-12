//
//  NewsDetailViewController.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import UIKit

class NewsDetailViewController: UIViewController {

    private var viewModel: NewsDetailViewModel!

    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var thumbnailImageView : UIImageView!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var descriptionLabel : UILabel!

    static func viewController(
        viewModel: NewsDetailViewModel
    ) -> NewsDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else {
            assertionFailure("NewsDetailViewController not found")
            return UIViewController() as! NewsDetailViewController
        }

        viewController.viewModel = viewModel
        return viewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        self.updateUI()
        
    }
    

    private func updateUI() {
        
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.authorLabel.text = viewModel.author
        self.thumbnailImageView.loadImage(fromUrl: viewModel.imageUrl ?? "")

    }
    
    @IBAction func seemoreButtonAction(_ sender: Any) {
        

        let webViewController = NewsWebViewController.viewController(
            viewModel: viewModel
        )
        
        self.present(webViewController, animated: true)

    }
    
    
}
