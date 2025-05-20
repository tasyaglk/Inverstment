//
//  StocksVM.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import Foundation

final class StocksVM {
    private weak var coordinator: AppCoordinator?
    private var lastSearchText: String?
    
    var isStocksSelected: Bool = true
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        self.filteredStocks = self.stocks
    }
    
    var stocks: [StocksModel] = [
        StocksModel(id: 0, imageURL: "YNDX", fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)", isFavourite: false),
        StocksModel(id: 1, imageURL: "YNDX",fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, imageURL: "YNDX",fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 3, imageURL: "YNDX",fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 4, imageURL: "YNDX",fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 5, imageURL: "YNDX",fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 6, imageURL: "YNDX",fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)", isFavourite: false),
        StocksModel(id: 7, imageURL: "YNDX",fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 8, imageURL: "YNDX",fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 9, imageURL: "YNDX",fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 10, imageURL: "YNDX",fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 11, imageURL: "YNDX",fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 12, imageURL: "YNDX",fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)", isFavourite: false),
        StocksModel(id: 13, imageURL: "YNDX",fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 14, imageURL: "YNDX",fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 15, imageURL: "YNDX",fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 16, imageURL: "YNDX",fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 17, imageURL: "YNDX",fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
    ]
    
    var currentStocks: [StocksModel] {
        isStocksSelected ? stocks : stocks.filter { $0.isFavourite ?? false }
    }
    
    var filteredStocks: [StocksModel] = []
    
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
    
    func changeFavouriteStatus(id: Int) {
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
