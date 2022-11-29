//
//  Item+CoreDataProperties.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: Int16
    @NSManaged public var productId: Int16
    @NSManaged public var updateDate: String?
    @NSManaged public var quantity: Int16

}

extension Item : Identifiable {

}
