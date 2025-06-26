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
    
    var isStocksSelected: Bool = true
    
    init(coordinator: AppCoordinator, stockService: StockService = StockService()) {
        self.coordinator = coordinator
        self.stockService = stockService
        self.filteredStocks = self.stocks
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
        if let index = stocks.firstIndex(where: { $0.id == id }) {
            let stock = stocks[index]
            let isFavourite = stock.isFavourite ?? false
            stocks[index] = StocksModel(stock: stock, isFavourite: !isFavourite)
            if let searchText = lastSearchText {
                search(text: searchText)
            } else {
                filteredStocks = currentStocks
            }
        } else {
            print("no \(id)")
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
