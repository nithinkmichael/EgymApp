//
//  NewsListTableViewCell.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import UIKit

struct NewsListCellViewModel {
    let title: String?
    let imageUrl: String?
    let author: String?
}

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var thumbnailImageView : UIImageView!
    @IBOutlet private var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.text = nil
        thumbnailImageView.image = nil
        authorLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureViewWith(_ viewModel: NewsListCellViewModel) {
        
        titleLabel.text = viewModel.title
        thumbnailImageView.loadImage(fromUrl: viewModel.imageUrl ?? "")
        authorLabel.text = viewModel.author
        
    }
    
}
