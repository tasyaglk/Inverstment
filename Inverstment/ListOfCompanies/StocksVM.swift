//
//  StocksVM.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import Foundation

final class StocksVM {
    private weak var coordinator: AppCoordinator?
    private let stockService: StockService
    private var lastSearchText: String?
    private let coreDataManager: CoreDataManager
    
    var isStocksSelected: Bool = true
    
    init(coordinator: AppCoordinator, stockService: StockService = StockService(), coreDataManager: CoreDataManager = CoreDataManager()) {
        self.coordinator = coordinator
        self.stockService = stockService
        self.filteredStocks = self.stocks
        self.coreDataManager = coreDataManager
    }
    
    var stocks: [StocksModel] = []
    
    var currentStocks: [StocksModel] {
        isStocksSelected ? stocks : stocks.filter { $0.isFavourite ?? false }
    }
    
    var filteredStocks: [StocksModel] = []
    
    func fetchStocks(completion: @escaping (Result<Void, StockServiceError>) -> Void) {
        stockService.fetchActiveStocks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedStocks):
                self.stocks = fetchedStocks
                self.filteredStocks = self.currentStocks
                if let searchText = self.lastSearchText {
                    self.search(text: searchText)
                }
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func search(text: String?) {
        lastSearchText = text
        if let text = text, !text.isEmpty {
            filteredStocks = currentStocks.filter {
                guard let fullName = $0.fullName?.lowercased() else { return false }
                let searchText = text.lowercased()
                return fullName.contains(searchText)
            }
        } else {
            filteredStocks = currentStocks
        }
    }
    
    func clearSearch() {
        lastSearchText = nil
        filteredStocks = currentStocks
    }
    
    func changeFavouriteStatus(id: UUID) {
        if coreDataManager.changeFavouriteStatus(id: id) {
            if let index = stocks.firstIndex(where: { $0.id == id }) {
                let stock = stocks[index]
                stocks[index] = StocksModel(
                    id: stock.id,
                    imageData: stock.imageData,
                    fullName: stock.fullName,
                    shortName: stock.shortName,
                    price: stock.price,
                    changesPercentage: stock.changesPercentage,
                    priceChanges: stock.priceChanges,
                    isFavourite: !(stock.isFavourite ?? false)
                )
                
                if let searchText = lastSearchText, !searchText.isEmpty {
                    search(text: searchText)
                } else if !isStocksSelected {
                    filteredStocks = stocks.filter { $0.isFavourite ?? false }
                } else {
                    filteredStocks = stocks
                }
            } else {
                print("no stock: \(id)")
            }
        } else {
            print("failed to update favourite status for ID: \(id)")
        }
    }
    
    func changeButton() {
        isStocksSelected.toggle()
        filteredStocks = isStocksSelected ? stocks : stocks.filter { $0.isFavourite ?? false }
        if let searchText = lastSearchText {
            search(text: searchText)
        }
    }
}
