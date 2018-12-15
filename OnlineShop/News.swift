//
//  News.swift
//  OnlineShop
//
//  Created by Laura Siewert on 15.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//

import Foundation
import UIKit

// Klasse für die Zelle Neuheiten

class News {
    var newsImage : UIImage
    var newsLabel : String
    
    init(newsImage: UIImage, newsLabel : String){
        self.newsImage = newsImage
        self.newsLabel = newsLabel
    }
}
