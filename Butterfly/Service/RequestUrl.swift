//
//  RequestUrl.swift
//  Butterfly
//
//  Created by Julien on 27/11/2022.
//

import Foundation

//Using enum for because of type-safe reason
//Can have different options within the RequestURL type
//For e.g API url for product order, invoice, etc
enum RequestURL {
    case productOrder
    
    func urlString() -> String {
        switch self {
            
        case .productOrder:
            return "https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
        }
    }
}
