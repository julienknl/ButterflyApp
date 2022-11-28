//
//  ProductOrder.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//

import Foundation
import UIKit

class ProductOrderRepository {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Fetch all product orders
    func findAll() -> [ProductOrder] {
        do {
            let items = try context.fetch(PurchaseOrder.fetchRequest())
            var tmpData: [ProductOrder] = []
            
            print(items)
            
            items.forEach { purchase in
                var order = ProductOrder()
                order.id = Int(purchase.id)
                order.last_updated = purchase.updateDate
                order.itemsCount = Int(purchase.itemsCount)
                tmpData.append(order)
            }
            return tmpData
        }
        catch {
            print("Error while fetching purchase orders")
            return []
        }
    }
    
    //Create a new product
    func create(product: ProductOrder) {
        let newProduct = PurchaseOrder(context: context)
        newProduct.id = Int16(findAll().count + 1)
        newProduct.itemsCount = 0
        newProduct.updateDate = Date().formatted()
        do {
            try context.save()
        }
        catch {
            print("Failed to create a new product")
        }
    }
    
    //Save a fetched product from the server
    func save(product: ProductOrder) {
        print("Product item count: \(product.items.count)")
        let newProduct = PurchaseOrder(context: context)
        guard let id = product.id else { return }
        newProduct.id = Int16(id)
        newProduct.itemsCount = Int16(product.items.count)
        newProduct.updateDate = product.last_updated
        do {
            try context.save()
        }
        catch {
            print("Failed to create a new product")
        }
    }
}
