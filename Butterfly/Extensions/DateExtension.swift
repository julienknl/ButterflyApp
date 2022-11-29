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
    
    ///Convert from ISO8601 formatted date to date
    func convertToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: self) ?? Date()
        
        return date
    }
}

extension Date {
    ///Convert date to millisecond
    var toMilliseconds: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    ///Convert from date to string
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
}
