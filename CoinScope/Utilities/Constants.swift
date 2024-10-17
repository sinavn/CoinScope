//
//  Constants.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//

import Foundation

struct Constants {
    static let CGBaseURL = "https://api.coingecko.com/api/v3"
    static let etherScanBseURL = "https://api.etherscan.io/api"
    static let CGAPIkey = ProcessInfo.processInfo.environment["CG_API_key"] ?? ""
    static let etherScanAPIKey =  ProcessInfo.processInfo.environment["ETHER_SCAN_APIKEY"] ?? ""
    static let googleCredintials = "104344604055-hqjp39l5c4igrip5bm7ppv3vge8e82ok.apps.googleusercontent.com"
}
