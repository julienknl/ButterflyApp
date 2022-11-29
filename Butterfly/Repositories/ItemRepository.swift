//
//  ItemRepository.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//

import Foundation
import UIKit
import CoreData

class ItemRepository {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Fetch all product items
    func findAll(productId: Int) -> [ProductItem] {
        do {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "productId == %i", productId)
            let items = try context.fetch(request)
            var tmpData: [ProductItem] = []
            
            items.forEach { value in
                var item = ProductItem()
                item.id = Int(value.id)
                item.last_updated = value.updateDate
                item.quantity = Int(value.quantity)
                tmpData.append(item)
            }
            return tmpData
        }
        catch {
            print("Error while fetching items")
            return []
        }
    }
    
    //Create a new product item
    func create(item: ProductItem, foreignId: Int16) {
        let newItem = Item(context: context)
        newItem.id = Int16(findAll(productId: Int(foreignId)).count + 1)
        newItem.updateDate = Date().formatted()
        newItem.productId = foreignId
        newItem.quantity = Int16(item.quantity ?? 0)
        do {
            try context.save()
        }
        catch {
            print("Failed to create a new product")
        }
    }
    
    //Save a fetched product item from the server
    func save(item: ProductItem, foreignId: Int16) {
        let newItem = Item(context: context)
        guard let id = item.id else { return }
        newItem.id = Int16(id)
        newItem.updateDate = item.last_updated
        newItem.productId = foreignId
        newItem.quantity = Int16(item.quantity ?? 0)
        do {
            try context.save()
        }
        catch {
            print("Failed to create a new product")
        }
    }
}
