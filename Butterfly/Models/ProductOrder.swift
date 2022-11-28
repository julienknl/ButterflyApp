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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case last_updated = "last_updated"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        last_updated = try container.decode(String.self, forKey: .last_updated)
        var nestedContainer = try container.nestedUnkeyedContainer(forKey: .items)
        
        while !nestedContainer.isAtEnd {
            do {
                let product = try nestedContainer.decode(ProductItem.self)
                items.append(product)
            }
            catch {
                print("Failed to loop")
            }
        }
    }
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

struct ProductItemWrapper: Decodable {
    var items: [ProductItem] = []
}


//struct ProductOrder: Decodable {
//    var details: Product?
////    var items: [ProductItem]?
//
//    init(from decoder: Decoder) throws {
//        var container = try decoder.unkeyedContainer()
////        let itemsWrapper = try container.decode(ProductItemWrapper.self)
//        let productWrapper = try container.decode(Product.self)
//        let nestedContainer = try container.nestedUnkeyedContainer(forKey: )
//
//
//        details = productWrapper
//        items = itemsWrapper.items
//    }
//}
//
//struct Product: Decodable {
//    var id: Int?
//    var last_updated: String?
//    var items: [[String : ProductItem]] = []
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case last_updated = "last_updated"
//        case items = "items"
//    }
//}
//
//struct ProductItem: Decodable {
//    var id: Int?
//    var product_item_id: Int?
//    var quantity: Int?
//    var last_updated_user_entity_id: Int?
//    var transient_identifier: String?
//    var active_flag: Bool?
//    var last_updated: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case product_item_id = "product_item_id"
//        case quantity = "quantity"
//        case last_updated_user_entity_id = "last_updated_user_entity_id"
//        case transient_identifier = "transient_identifier"
//        case active_flag = "active_flag"
//        case last_updated = "last_updated"
//    }
//}
//
//struct ProductItemWrapper: Decodable {
//    var items: [ProductItem] = []
//}
