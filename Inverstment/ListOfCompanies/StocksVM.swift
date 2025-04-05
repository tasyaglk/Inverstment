//
//  StocksVM.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import Foundation

class StocksVM {
    weak var coordinator: AppCoordinator?

    var stocks: [StocksModel] = [
        StocksModel(id: 0, fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)"),
        StocksModel(id: 1, fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)"),
        StocksModel(id: 3, fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)"),
        StocksModel(id: 4, fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)"),
        StocksModel(id: 5, fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 0, fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)"),
        StocksModel(id: 1, fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)"),
        StocksModel(id: 3, fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)"),
        StocksModel(id: 4, fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)"),
        StocksModel(id: 5, fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 0, fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)"),
        StocksModel(id: 1, fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)"),
        StocksModel(id: 3, fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)"),
        StocksModel(id: 4, fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)"),
        StocksModel(id: 5, fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
    ]
    
    func changeFavouriteStatus(id: Int) {
        stocks[id].isFavourite?.toggle()
    }
}
