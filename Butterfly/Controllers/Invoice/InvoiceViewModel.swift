//
//  InvoiceViewModel.swift
//  Butterfly
//
//  Created by Julien on 29/11/2022.
//

import Foundation

class InvoiceViewModel: NSObject {
    
    private let repository = InvoiceRepository()
    
    private (set) var invoices: [ProductInvoice] = [] {
        didSet {
            DispatchQueue.main.async {
                self.invoiceLiveData()
            }
        }
    }
    
    var invoiceLiveData: (() -> ()) = {}
    
    private var productId: Int?
    
    required init(productId: Int) {
        super.init()
        self.productId = productId
        getInvoices()
    }
    
    private func getInvoices() {
        guard let id = productId else { return }
        invoices = repository.findAll(productId: id)
    }
}
