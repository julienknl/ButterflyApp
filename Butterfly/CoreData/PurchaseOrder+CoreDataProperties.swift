//
//  PurchaseOrder+CoreDataProperties.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//
//

import Foundation
import CoreData


extension PurchaseOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrder> {
        return NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
    }

    @NSManaged public var id: Int16
    @NSManaged public var itemsCount: Int16
    @NSManaged public var updateDate: String?

}

extension PurchaseOrder : Identifiable {

}
