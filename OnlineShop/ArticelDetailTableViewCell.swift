//
//  ArticelDetailTableViewCell.swift
//  OnlineShop
//
//  Created by Laura Siewert on 20.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

class ArticelDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var articelName: UILabel!
    @IBOutlet weak var articelDescription: UILabel!
    @IBOutlet weak var articelPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setArticelDetail(preview: Articel){
        articelName.text = preview.articelName
        articelPrice.text = String(preview.articelPrice)
        articelDescription.text = preview.articelDescription
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
