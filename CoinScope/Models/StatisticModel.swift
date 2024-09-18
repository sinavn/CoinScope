//
//  StatisticModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/19/1403 AP.
//

import Foundation

struct StatisticModel : Identifiable {
    let id = UUID().uuidString
    let title : String
    let value : String
    let changePrecent : Double?
    
    init(title: String, value: String, changePrecent: Double? = nil) {
        self.title = title
        self.value = value
        self.changePrecent = changePrecent
    }
    

}
