//
//  StocksVM.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import Foundation

final class StocksVM {
    private weak var coordinator: AppCoordinator?
    
    init(coordinator: AppCoordinator) {
            self.coordinator = coordinator
        }

    var stocks: [StocksModel] = [
        StocksModel(id: 0, imageURL: "YNDX", fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)", isFavourite: false),
        StocksModel(id: 1, imageURL: "YNDX",fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, imageURL: "YNDX",fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 3, imageURL: "YNDX",fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 4, imageURL: "YNDX",fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 5, imageURL: "YNDX",fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 0, imageURL: "YNDX",fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)", isFavourite: false),
        StocksModel(id: 1, imageURL: "YNDX",fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, imageURL: "YNDX",fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 3, imageURL: "YNDX",fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 4, imageURL: "YNDX",fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 5, imageURL: "YNDX",fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 0, imageURL: "YNDX",fullName: "Yandex, LLC", shortName: "YNDX", price: "4 764,6 ₽", priceChanges: "+55 ₽ (1,15%)", isFavourite: false),
        StocksModel(id: 1, imageURL: "YNDX",fullName: "Apple Inc.", shortName: "AAPL", price: "$131.93", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
        StocksModel(id: 2, imageURL: "YNDX",fullName: "Alphabet Class A", shortName: "GOOGL", price: "$1 825", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 3, imageURL: "YNDX",fullName: "Amazon.com", shortName: "AMZN", price: "$3 204", priceChanges: "-$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 4, imageURL: "YNDX",fullName: "Bank of America Corp", shortName: "BAC", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: false),
        StocksModel(id: 5, imageURL: "YNDX",fullName: "Microsoft Corporation", shortName: "MSFT", price: "$3 204", priceChanges: "+$0.12 (1,15%)", isFavourite: true),
    ]
    
    func changeFavouriteStatus(id: Int) {
        var stock = stocks[id]
        stocks[id] = StocksModel(id: stock.id, imageURL: stock.imageURL, fullName: stock.fullName, shortName: stock.shortName, price: stock.price, priceChanges: stock.priceChanges, isFavourite: !(stock.isFavourite ?? false))
    }
}
