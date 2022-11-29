//
//  InvoiceRepository.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import Foundation
import UIKit
import CoreData

class InvoiceRepository {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Fetch all product items
    func findAll(productId: Int) -> [ProductInvoice] {
        do {
            let request: NSFetchRequest<Invoice> = Invoice.fetchRequest()
            request.predicate = NSPredicate(format: "productId == %i", productId)
            let invoices = try context.fetch(request)
            var tmpData: [ProductInvoice] = []
            
            invoices.forEach { value in
                var invoice = ProductInvoice()
                invoice.invoice_number = value.number
                invoice.received_status = Int(value.status)
                tmpData.append(invoice)
            }
            return tmpData
        }
        catch {
            print("Error while fetching items")
            return []
        }
    }
    
    //Save a fetched product item from the server
    func save(invoice: ProductInvoice, foreignId: Int16) {
        let newItem = Invoice(context: context)
        guard let number = invoice.invoice_number else { return }
        newItem.number = number
        newItem.status = Int16(invoice.received_status ?? 0)
        newItem.productId = foreignId
        
        do {
            try context.save()
        }
        catch {
            print("Failed to create a new product")
        }
    }
}
