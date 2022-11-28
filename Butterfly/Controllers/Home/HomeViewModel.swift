//
//  HomeViewModel.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//

import Foundation

class HomeViewModel: NSObject {
    
    private let request: RequestService = RequestService()
    
    private (set) var products: [ProductOrder] = [] {
        didSet {
            self.productsLiveData()
        }
    }
    var productsLiveData: (() -> ()) = {}
    
    override init() {
        super.init()
        self.getProducts()
    }
    
    private func getProducts() {
        request.simpleRequest(url: .productOrder) { [weak self] result in
            switch result {
                
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([ProductOrder].self, from: data as? Data ?? Data())
                    let repository = ProductOrderRepository()
                    
                    self?.saveProductLocally(response: response)
                    self?.products = repository.findAll()
                    
                    let itemRepository = ItemRepository()
                    print(itemRepository.findAll(productId: 1))
                }
                catch (let error) {
                    print("Failed to decode product orders data - \(error)")
                }
            case .failure(let error):
                switch error {
                    
                case .noInternetConnection:
                    break
                case .failed, .unknown:
                    break
                }
            }
        }
    }
    
    private func saveProductLocally(response: [ProductOrder]) {
        let productRepository = ProductOrderRepository()
        let itemRepository = ItemRepository()
        
        response.forEach { product in
            guard let id = product.id else { return }
            let responseLatestDate = Int(product.last_updated?.convertToDate().toMilliseconds ?? 0)
            let localLatestDate = Int(productRepository.findAll().first(where: {$0.id == id})?.last_updated?.convertToDate().toMilliseconds ?? 0)
            
            if responseLatestDate > localLatestDate {
                productRepository.save(product: product)
                
                product.items.forEach { item in
                    itemRepository.save(item: item, foreignId: Int16(id))
                }
            }
        }
    }
}
