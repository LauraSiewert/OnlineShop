//
//  MainCategory+CoreDataProperties.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//
//

import Foundation
import CoreData


extension MainCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainCategory> {
        return NSFetchRequest<MainCategory>(entityName: "MainCategory")
    }

    @NSManaged public var mainCategoryImage: String?
    @NSManaged public var mainCategoryName: String?
    @NSManaged public var subCategories: NSSet?

}

// MARK: Generated accessors for subCategories
extension MainCategory {

    @objc(addSubCategoriesObject:)
    @NSManaged public func addToSubCategories(_ value: SubCategory)

    @objc(removeSubCategoriesObject:)
    @NSManaged public func removeFromSubCategories(_ value: SubCategory)

    @objc(addSubCategories:)
    @NSManaged public func addToSubCategories(_ values: NSSet)

    @objc(removeSubCategories:)
    @NSManaged public func removeFromSubCategories(_ values: NSSet)

}
