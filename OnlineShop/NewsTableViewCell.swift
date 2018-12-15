//
//  NewsTableViewCell.swift
//  OnlineShop
//
//  Created by Laura Siewert on 15.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setNews(preview: News){
        newsImage.image = preview.newsImage
        newsLabel.text = preview.newsLabel
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
