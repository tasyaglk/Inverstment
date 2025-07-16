//
//  StockService.swift
//  Inverstment
//
//  Created by Тася Галкина on 26.06.2025.
// 

import UIKit

final class StockService {
    private let config: StockServiceConfig
    private let session: URLSession
    private let coreDataManager: CoreDataManager
    
    init(config: StockServiceConfig = StockServiceConfig(),
         session: URLSession = .shared,
         coreDataManager: CoreDataManager = CoreDataManager()) {
        self.config = config
        self.session = session
        self.coreDataManager = coreDataManager
    }
    
    private func fetchImage(from urlString: String, completion: @escaping (Result<Data, StockServiceError>) -> Void) {
        guard let url = URL(string: urlString) else {
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
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
    
    func fetchActiveStocks(completion: @escaping (Result<[StocksModel], StockServiceError>) -> Void) {
        guard let url = URL(string: "\(config.baseURL)?apikey=\(config.apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
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
                
                var stocks: [StocksModel?] = Array(repeating: nil, count: jsonArray.count)
                let group = DispatchGroup()
                let lock = NSLock()
                
                for (index, dict) in jsonArray.enumerated() {
                    guard let ticker = dict["ticker"] as? String,
                          let changes = dict["changes"] as? Double,
                          let price = dict["price"] as? String,
                          let changesPercentage = dict["changesPercentage"] as? String,
                          let companyName = dict["companyName"] as? String else {
                        continue
                    }
                    
                    let percentageValue = Double(changesPercentage) ?? 0.0
                    let formattedPercentage = String(format: "%.2f", abs(percentageValue))
                    
                    let fullPrice: String
                    if changesPercentage.hasPrefix("-") {
                        fullPrice = "-$\(String(format: "%.2f", abs(changes))) (\(formattedPercentage)%)"
                    } else {
                        fullPrice = "+$\(String(format: "%.2f", abs(changes))) (\(formattedPercentage)%)"
                    }
                    
                    let imageURL = "\(config.imageBaseURL)/\(ticker).png"
                    
                    if let existingStock = self.coreDataManager.fetchStock(ticker: ticker) {
                        let stockModel = StocksModel(
                            id: existingStock.id ?? UUID(),
                            imageData: existingStock.image,
                            fullName: existingStock.fullName ?? "",
                            shortName: existingStock.shortName ?? "",
                            price: existingStock.price ?? "",
                            changesPercentage: existingStock.changesPercentage ?? "",
                            priceChanges: existingStock.priceChanges ?? "",
                            isFavourite: existingStock.isFavourite
                        )
                        lock.lock()
                        stocks[index] = stockModel
                        lock.unlock()
                        continue
                    }
                    
                    group.enter()
                    fetchImage(from: imageURL) { result in
                        let stockModel = StocksModel(
                            id: UUID(),
                            imageData: result.success,
                            fullName: companyName,
                            shortName: ticker,
                            price: "$" + price,
                            changesPercentage: changesPercentage,
                            priceChanges: fullPrice,
                            isFavourite: false
                        )
                        
                        lock.lock()
                        
                        self.coreDataManager.saveStock(stock: stockModel, imageData: result.success)
                        stocks[index] = stockModel
                        
                        lock.unlock()
                        
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    let finalStocks = stocks.compactMap { $0 }
                    completion(.success(finalStocks))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        DispatchQueue.global().async {
            task.resume()
        }
    }
}
