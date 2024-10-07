//
//  NetworkinManager.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 5/30/1403 AP.
//

import Foundation
import Combine

class NetworkinManager {
    
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
    static func downloadData(url : URL) async throws -> Data{
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {throw NetworkError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 1)}
        return data
//        URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap(handleResponse)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
    }
    
    static func download(url : URL)-> AnyPublisher<Data, any Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleResponse(data:Data,response:URLResponse)throws->Data{
        guard let httpRespons = response as? HTTPURLResponse , httpRespons.statusCode >= 200 && httpRespons.statusCode < 300 else{
            throw NetworkError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 1)
        }
        return data
    }
    
    static func handleCompletion (completion : Subscribers.Completion<Error>){
           switch completion {
           case .finished :
               break
           case .failure(let error):
               print(error)
           }
    }
    
   static func getGasPrice () async throws -> GweiModel{
        guard let url = URL(string: Constants.etherScanBseURL + "?module=gastracker&action=gasoracle&apikey=" + Constants.etherScanAPIKey) else {
            throw NetworkError.invalidURL
        }
        do {
            let (data , response) = try await URLSession.shared.data(from: url)
            guard let urlResponse = response as? HTTPURLResponse else { throw NetworkError.unknownError}
            if urlResponse.statusCode >= 200 && urlResponse.statusCode < 300 {
                do{
                    let result = try JSONDecoder().decode(GweiModel.self, from: data)
                    return result
                }catch let decodingError{
                   throw  NetworkError.decodingFailed(decodingError)
                }
            }else{
                throw NetworkError.serverError(statusCode: urlResponse.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        }
    }
}
