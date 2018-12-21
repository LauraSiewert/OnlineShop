//
//  ArticelImageTableViewCell.swift
//  OnlineShop
//
//  Created by Laura Siewert on 20.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

class ArticelImageTableViewCell: UITableViewCell{

    @IBOutlet weak var articelImage: UIImageView!
    @IBOutlet weak var articelColor: UIButton!
    @IBOutlet weak var articelSize: UIButton!
    @IBOutlet weak var articelAmount: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setArticelImage(preview: Articel){
        articelImage.image = preview.articelImage?.toImage()
        articelSize.setImage(preview.articelSize?.toImage(), for: UIControl.State.normal)
        articelSize.setImage(preview.articelSize?.toImage(), for: UIControl.State.normal)
        articelAmount.setTitle("0", for: UIControl.State.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
