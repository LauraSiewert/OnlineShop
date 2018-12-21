//
//  ArticelOverviewCollectionViewCell.swift
//  OnlineShop
//
//  Created by Laura Siewert on 16.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

class ArticelOverviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var articelImage: UIImageView!
    @IBOutlet weak var articelName: UILabel!
    @IBOutlet weak var articelPrice: UILabel!
    
    
    func setArticel(preview: Articel){
        articelImage.image = preview.articelImage?.toImage()
        articelName.text = preview.articelName
        articelPrice.text = String(preview.articelPrice)
    }
}
