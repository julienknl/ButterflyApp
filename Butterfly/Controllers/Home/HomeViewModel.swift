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
    
    func getProducts() {
        request.simpleRequest(url: .productOrder) { [weak self] result in
            switch result {
                
            case .success(let data):
                print(data)
                do {
                    let response = try JSONDecoder().decode([ProductOrder].self, from: data as? Data ?? Data())
                    self?.products = response
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
}
