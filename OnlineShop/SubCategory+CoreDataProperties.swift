//
//  SubCategory+CoreDataProperties.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//
//

import Foundation
import CoreData


extension SubCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubCategory> {
        return NSFetchRequest<SubCategory>(entityName: "SubCategory")
    }

    @NSManaged public var subCategoryName: String?
    @NSManaged public var subCategoryImage: String?
    @NSManaged public var mainCategory: MainCategory?
    @NSManaged public var articels: NSSet?

}

// MARK: Generated accessors for articels
extension SubCategory {

    @objc(addArticelsObject:)
    @NSManaged public func addToArticels(_ value: Articel)

    @objc(removeArticelsObject:)
    @NSManaged public func removeFromArticels(_ value: Articel)

    @objc(addArticels:)
    @NSManaged public func addToArticels(_ values: NSSet)

    @objc(removeArticels:)
    @NSManaged public func removeFromArticels(_ values: NSSet)

}
