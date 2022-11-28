//
//  Invoice+CoreDataProperties.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var number: Int16
    @NSManaged public var status: String?

}

extension Invoice : Identifiable {

}
