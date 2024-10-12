//
//  String.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 7/21/1403 AP.
//

import Foundation

extension String {
    var removingHTMLOccurances : String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
