//
//  DateExtension.swift
//  Butterfly
//
//  Created by Julien on 28/11/2022.
//

import Foundation

extension String {
    
    ///Convert from ISO8601 formatted date to string new format yyyy-MM-dd
    func convertToReadableDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: self) ?? Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}
