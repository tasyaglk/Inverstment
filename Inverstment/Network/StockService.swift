//
//  StockService.swift
//  Inverstment
//
//  Created by Тася Галкина on 26.06.2025.
//

import UIKit

class StockService {
    private let config: StockServiceConfig
    private let session: URLSession
    
    init(config: StockServiceConfig = StockServiceConfig(),
         session: URLSession = .shared) {
        self.config = config
        self.session = session
    }
    
    func fetchActiveStocks(completion: @escaping (Result<[StocksModel], StockServiceError>) -> Void) {
        guard let url = URL(string: "\(config.baseURL)?apikey=\(config.apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidJSONFormat))
                }
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let jsonArray = json?["mostActiveStock"] as? [[String: Any]] else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidJSONFormat))
                    }
                    return
                }
                
                let stocks = jsonArray.compactMap { dict -> StocksModel? in
                    guard let ticker = dict["ticker"] as? String,
                          let changes = dict["changes"] as? Double,
                          let price = dict["price"] as? String,
                          let changesPercentage = dict["changesPercentage"] as? String,
                          let companyName = dict["companyName"] as? String else {
                        return nil
                    }
                
                    let priceValue = Double(price) ?? 0.0
                    
                    
                    let percentageValue = Double(changesPercentage) ?? 0.0
                    let formattedPercentage = String(format: "%.2f", abs(percentageValue))
                    
                    
                    let fullPrice: String
                    if changesPercentage.hasPrefix("-") {
                        fullPrice = "-$\(String(format: "%.2f", abs(changes))) (\(formattedPercentage)%)"
                    } else {
                        fullPrice = "+$\(String(format: "%.2f", abs(changes))) (\(formattedPercentage)%)"
                    }
                    
                    return StocksModel(
                        id: UUID(),
                        imageURL: nil,
                        fullName: companyName,
                        shortName: ticker,
                        price: "$" + price, // как подтянуть валюту?
                        changesPercentage: changesPercentage,
                        priceChanges: fullPrice,
                        isFavourite: false
                    )
                }
                
                DispatchQueue.main.async {
                    completion(.success(stocks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
}
