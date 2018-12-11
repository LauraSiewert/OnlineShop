//
//  MainCategoriesTableViewCell.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import UIKit

protocol MainCategoryDelegate {
    //func buttonPressed(cell: UITableViewCell)
}

class MainCategoriesTableViewCell: UITableViewCell {


    @IBOutlet weak var mainCategoryImage: UIImageView!
    @IBOutlet weak var mainCategoryName: UILabel!
    var delegate: MainCategoryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setMainCategory(preview: MainCategory){
        mainCategoryImage.image = preview.mainCategoryImage?.toImage()
        mainCategoryName.text = preview.mainCategoryName
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
