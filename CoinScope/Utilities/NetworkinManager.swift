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
    
    static func download (url : URL)-> AnyPublisher<Data, any Error>{
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
}
