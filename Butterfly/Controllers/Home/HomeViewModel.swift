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
    
    //Get product from the server
    private func getProducts() {
        request.simpleRequest(url: .productOrder) { [weak self] result in
            switch result {
                
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([ProductOrder].self, from: data as? Data ?? Data())
                    let repository = ProductOrderRepository()
                    
                    self?.saveProductLocally(response: response)
                    self?.products = repository.findAll()
                }
                catch (let error) {
                    print("Failed to decode product orders data - \(error)")
                }
            case .failure(let error):
                switch error {
                    
                case .noInternetConnection:
                    print("ERROR with no internet connection")
                case .failed, .unknown:
                    print("ERROR failed request. Please try again later.")
                }
            }
        }
    }
    
    //Save to core data
    private func saveProductLocally(response: [ProductOrder]) {
        let productRepository = ProductOrderRepository()
        let itemRepository = ItemRepository()
        let invoiceRepository = InvoiceRepository()
        
        response.forEach { product in
            guard let id = product.id else { return }
            let responseLatestDate = Int(product.last_updated?.convertToDate().toMilliseconds ?? 0)
            let localLatestDate = Int(productRepository.findAll().first(where: {$0.id == id})?.last_updated?.convertToDate().toMilliseconds ?? 0)
            
            if responseLatestDate > localLatestDate {
                productRepository.save(product: product)
                
                //Save items to core data
                if !product.items.isEmpty {
                    product.items.forEach { item in
                        itemRepository.save(item: item, foreignId: Int16(id))
                    }
                }
                
                //Save invoices to core data
                if !product.invoices.isEmpty {
                    product.invoices.forEach { invoice in
                        invoiceRepository.save(invoice: invoice, foreignId: Int16(id))
                    }
                }
            }
        }
    }
    
    func add() {
        var product = ProductOrder()
        product.itemsCount = 0
        product.last_updated = Date().toString
        let repository = ProductOrderRepository()
        repository.create(product: product, completion: { [weak self] id in
            product.id = id
            self?.products.append(product)
        })
    }
}
