//
//  Receipt+CoreDataProperties.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var id: Int16

}

extension Receipt : Identifiable {

}
