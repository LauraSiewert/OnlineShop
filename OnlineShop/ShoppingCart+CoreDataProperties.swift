//
//  ShoppingCart+CoreDataProperties.swift
//  OnlineShop
//
//  Created by Laura Siewert on 07.12.18.
//  Copyright © 2018 Laura Siewert. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingCart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCart> {
        return NSFetchRequest<ShoppingCart>(entityName: "ShoppingCart")
    }

    @NSManaged public var inCart: Bool
    @NSManaged public var articelsInCart: NSSet?

}

// MARK: Generated accessors for articelsInCart
extension ShoppingCart {

    @objc(addArticelsInCartObject:)
    @NSManaged public func addToArticelsInCart(_ value: Articel)

    @objc(removeArticelsInCartObject:)
    @NSManaged public func removeFromArticelsInCart(_ value: Articel)

    @objc(addArticelsInCart:)
    @NSManaged public func addToArticelsInCart(_ values: NSSet)

    @objc(removeArticelsInCart:)
    @NSManaged public func removeFromArticelsInCart(_ values: NSSet)

}
