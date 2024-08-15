//
//  DoubleExt.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/25/1403 AP.
//

import Foundation

extension Double {
    
    /// converts a double into currency with 2-6 decimals
    ///```
    ///convert 1234.54 to $123,4.54
    ///```
    private var currencyFormatter6 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        return formatter
    }
    func asCurrencyWith6Decimals()->String{
        let number = NSNumber(value: self)
       return currencyFormatter6.string(from: number) ?? "$0.000"
    }
    
   
    func asNumberString()->String{
        return String(format: "%.2f", self)
    }
    func asPercentString()->String{
        return String(format: "%.2f", self) + "%"
    }
}
