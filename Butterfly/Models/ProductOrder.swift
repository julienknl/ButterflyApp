//
//  ProductOrder.swift
//  Butterfly
//
//  Created by Julien on 27/11/2022.
//

import Foundation

struct ProductOrder: Decodable {
    var id: Int?
    var last_updated: String?
    var items: [ProductItem] = []
    var invoices: [ProductInvoice] = []
    var itemsCount = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case last_updated = "last_updated"
        case items = "items"
        case invoices = "invoices"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        last_updated = try container.decode(String.self, forKey: .last_updated)
        var itemsContainer = try container.nestedUnkeyedContainer(forKey: .items)
        var invoicesContainer = try container.nestedUnkeyedContainer(forKey: .invoices)
        
        while !itemsContainer.isAtEnd {
            do {
                let product = try itemsContainer.decode(ProductItem.self)
                items.append(product)
            }
            catch {
                print("Failed to decode items")
            }
        }
        
        while !invoicesContainer.isAtEnd {
            do {
                let invoice = try invoicesContainer.decode(ProductInvoice.self)
                invoices.append(invoice)
            }
            catch {
                print("Failed to decode invoices")
            }
        }
    }
    
    init() {}
}

struct Product: Decodable {
    var id: Int?
    var last_updated: String?
    var items: [[String : ProductItem]] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case last_updated = "last_updated"
        case items = "items"
    }
}

struct ProductItem: Decodable {
    var id: Int?
    var product_item_id: Int?
    var quantity: Int?
    var last_updated_user_entity_id: Int?
    var transient_identifier: String?
    var active_flag: Bool?
    var last_updated: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_item_id = "product_item_id"
        case quantity = "quantity"
        case last_updated_user_entity_id = "last_updated_user_entity_id"
        case transient_identifier = "transient_identifier"
        case active_flag = "active_flag"
        case last_updated = "last_updated"
    }
}

struct ProductInvoice: Decodable {
    var invoice_number: String?
    var received_status: Int?
    
    enum CodingKeys: String, CodingKey {
        case invoice_number = "invoice_number"
        case received_status = "received_status"
    }
}
