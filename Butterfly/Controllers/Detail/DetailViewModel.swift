//
//  DetailViewModel.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import Foundation

class DetailViewModel: NSObject {
    
    private let repository = ItemRepository()
    
    private (set) var items: [ProductItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.itemLiveData()
            }
        }
    }
    
    private var productId: Int?
    
    var itemLiveData: (() -> ()) = {}
    
    required init(productId: Int) {
        super.init()
        self.productId = productId
        getItems()
    }
    
    private func getItems() {
        guard let id = productId else { return }
        items = repository.findAll(productId: id)
    }
}
