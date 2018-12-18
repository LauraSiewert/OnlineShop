//
//  SubCategoryTableViewCell.swift
//  OnlineShop
//
//  Created by Laura Siewert on 15.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var subCategoryImage: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    func setSubCategory(preview: SubCategory){
        subCategoryImage.image = preview.subCategoryImage?.toImage()
        subCategoryLabel.text = preview.subCategoryName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
