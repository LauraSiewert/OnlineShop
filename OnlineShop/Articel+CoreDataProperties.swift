//
//  Articel+CoreDataProperties.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//
//

import Foundation
import CoreData


extension Articel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Articel> {
        return NSFetchRequest<Articel>(entityName: "Articel")
    }

    @NSManaged public var articelName: String?
    @NSManaged public var articelAmount: String?
    @NSManaged public var articelDescription: String?
    @NSManaged public var articelImage: String?
    @NSManaged public var articelPrice: Double
    @NSManaged public var articelSize: String?
    @NSManaged public var articelColor: String?
    @NSManaged public var subCategory: SubCategory?
    @NSManaged public var inCart: ShoppingCart?

}
