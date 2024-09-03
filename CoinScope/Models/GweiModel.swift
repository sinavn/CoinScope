//
//  GweiModel.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/13/1403 AP.
//

import Foundation
struct GweiModel : Codable {
    let low : Double
    let average : Double
    let high : Double
    
    init(from decoder: Decoder) throws {
        // Get the container that holds the top-level key-value pairs
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Extract the nested `result` container
        let resultContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
        
        if let lowString = try? resultContainer.decode(String.self, forKey: .low),
           let lowValue = Double(lowString) {
            self.low = lowValue
        } else {
            throw DecodingError.dataCorruptedError(forKey: .low, in: resultContainer, debugDescription: "Expected a double value for low")
        }
        
        if let averageString = try? resultContainer.decode(String.self, forKey: .average),
           let averageValue = Double(averageString) {
            self.average = averageValue
        } else {
            throw DecodingError.dataCorruptedError(forKey: .average, in: resultContainer, debugDescription: "Expected a double value for average")
        }
        
        if let highString = try? resultContainer.decode(String.self, forKey: .high),
           let highValue = Double(highString) {
            self.high = highValue
        } else {
            throw DecodingError.dataCorruptedError(forKey: .high, in: resultContainer, debugDescription: "Expected a double value for high")
        }
    }
    
    enum CodingKeys: String , CodingKey {
        case result
        case low = "SafeGasPrice"
        case average = "ProposeGasPrice"
        case high = "FastGasPrice"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Extract the nested `result` container
        var resultContainer =  container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
        
        
        try resultContainer.encode(String(low), forKey: .low)
        try resultContainer.encode(String(average), forKey: .average)
        try resultContainer.encode(String(high), forKey: .high)
    }
}
