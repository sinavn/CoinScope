//
//  DownloadManager.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/23/1403 AP.
//

import Foundation

class DownloadManager {
    static let shared = DownloadManager()
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingFailed(Error)
        case serverError(statusCode: Int)
        case unknownError

        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "The URL provided was invalid."
            case .noData:
                return "No data was received from the server."
            case .decodingFailed(let error):
                return "Failed to decode the data: \(error.localizedDescription)"
            case .serverError(let statusCode):
                return "Server error occurred with status code: \(statusCode)."
            case .unknownError:
                return "An unknown error occurred."
            }
        
        }
    }

    func getCoinData ()async throws -> [CoinModel]{
        guard let url = URL(string: Constants.base_url+"/coins/markets?x_cg_demo_api_key="+Constants.apikey+"&vs_currency=usd&sparkline=true&price_change_percentage=24h&order=market_cap_desc") else {
            throw NetworkError.invalidURL
        }
        do {
              let (data , response) = try await URLSession.shared.data(from: url)
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 200 , response.statusCode < 300 {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode([CoinModel].self, from: data)
                    return result
                }else{
                    throw NetworkError.serverError(statusCode: response.statusCode)
                }
            }else{
                throw NetworkError.unknownError
            }
        } catch let error {
            throw NetworkError.decodingFailed(error)
        }
    }
        
}
