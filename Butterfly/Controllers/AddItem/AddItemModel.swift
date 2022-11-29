//
//  AddItemModel.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import Foundation

class AddItemModel {
    
    private let repository = ItemRepository()
    
    func add(productId: Int, quantity: Int, completion: (() -> ())!) {
        let productRepository = ProductOrderRepository()
        
        repository.create(quantity: quantity, foreignId: Int16(productId)) {

            productRepository.update(productId: productId, quantity: (self.repository.findQuantityBy(productId: productId) - 1) + 1)
            
            if completion != nil {
                completion()
            }
            
        }
    }
}
