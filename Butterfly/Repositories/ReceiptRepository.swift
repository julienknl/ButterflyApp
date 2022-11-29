//
//  ReceiptRepository.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import Foundation
import UIKit
import CoreData

class ReceiptRepository {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Fetch all receipts
    func findAll(productId: Int) -> [Receipt] {
        do {
            let request: NSFetchRequest<Receipt> = Receipt.fetchRequest()
            request.predicate = NSPredicate(format: "productId == %i", productId)
            let receipts = try context.fetch(request)
        
            return receipts
        }
        catch {
            print("Error while fetching items")
            return []
        }
    }
    
    //Save a fetched receipt from the server
    func save(id: Int, foreignId: Int16) {
        let newReceipt = Receipt(context: context)
        newReceipt.id = Int16(id)
        newReceipt.productId = foreignId
        
        do {
            try context.save()
        }
        catch {
            print("Failed to create a new product")
        }
    }
}
