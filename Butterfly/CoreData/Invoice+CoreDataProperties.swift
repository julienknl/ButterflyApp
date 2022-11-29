//
//  Invoice+CoreDataProperties.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var number: String?
    @NSManaged public var status: Int16
    @NSManaged public var productId: Int16

}

extension Invoice : Identifiable {

}
