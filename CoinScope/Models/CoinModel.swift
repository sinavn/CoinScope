//
//  CoinModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//
  // JSON RESPONSE
/*{
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    "current_price": 58957,
    "market_cap": 1164277481468,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1238597771311,
    "total_volume": 31660659717,
    "high_24h": 61538,
    "low_24h": 58831,
    "price_change_24h": -1759.0081055337214,
    "price_change_percentage_24h": -2.89708,
    "market_cap_change_24h": -33907110492.062256,
    "market_cap_change_percentage_24h": -2.82987,
    "circulating_supply": 19739925,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 73738,
    "ath_change_percentage": -19.98145,
    "ath_date": "2024-03-14T07:10:36.635Z",
    "atl": 67.81,
    "atl_change_percentage": 86915.03325,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-08-14T19:44:52.355Z",
    "sparkline_in_7d": {
        "price": [
            55136.98007317448,
            54770.26436291755,
        ]
    },"price_change_percentage_24h_in_currency": -3.05307391619245
}*/


   import Foundation
struct CoinModel : Codable , Identifiable , Equatable , Hashable{
    static func == (lhs: CoinModel, rhs: CoinModel) -> Bool {
        lhs.id == rhs.id 
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id, symbol, name: String
    let image: String
    let currentPrice : Double
    let marketCapRank : Int
    let marketCap, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D : SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings : Double?
    
    //    enum CodingKeys: String, CodingKey {
    //            case id, symbol, name, image
    //            case currentPrice = "current_price"
    //            case marketCap = "market_cap"
    //            case marketCapRank = "market_cap_rank"
    //            case fullyDilutedValuation = "fully_diluted_valuation"
    //            case totalVolume = "total_volume"
    //            case high24H = "high_24h"
    //            case low24H = "low_24h"
    //            case priceChange24H = "price_change_24h"
    //            case priceChangePercentage24H = "price_change_percentage_24h"
    //            case marketCapChange24H = "market_cap_change_24h"
    //            case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
    //            case circulatingSupply = "circulating_supply"
    //            case totalSupply = "total_supply"
    //            case maxSupply = "max_supply"
    //            case ath
    //            case athChangePercentage = "ath_change_percentage"
    //            case athDate = "ath_date"
    //            case atl
    //            case atlChangePercentage = "atl_change_percentage"
    //            case atlDate = "atl_date"
    //                case lastUpdated = "last_updated"
    //        }
    
    func updateHolding (amount :Double)-> CoinModel{
        return   CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCapRank: marketCapRank, marketCap: marketCap, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue : Double? {
        
        return currentPrice * (currentHoldings ?? 0)
    }
}
struct SparklineIn7D : Codable {
    let price: [Double]?
}

