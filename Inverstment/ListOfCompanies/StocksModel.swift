//
//  StocksModel.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import Foundation

struct StocksModel {
    
    //    https://financialmodelingprep.com/api/v3/stock/actives?apikey=
    //    {
    //        - "ticker": "SOFI",
    //         -"changes": 0.16,
    //         -"price": "15.36",
    //        - "changesPercentage": "1.05263",
    //         -"companyName": "SoFi Technologies, Inc."
    //       }
    
    let id: UUID?
    let imageData: Data?
    let fullName: String?
    let shortName: String?
    let price: String?
    let changesPercentage: String?
    let priceChanges: String?
    let isFavourite: Bool?
    
    init(
        id: UUID?,
        imageData: Data?,
        fullName: String?,
        shortName: String?,
        price: String?,
        changesPercentage: String?,
        priceChanges: String?,
        isFavourite: Bool?
    ) {
        self.id = id
        self.imageData = imageData
        self.fullName = fullName
        self.shortName = shortName
        self.price = price
        self.changesPercentage = changesPercentage
        self.priceChanges = priceChanges
        self.isFavourite = isFavourite
    }
    
    init(
        stock: StocksModel,
        id: UUID? = nil,
        imageData: Data? = nil,
        fullName: String? = nil,
        shortName: String? = nil,
        price: String? = nil,
        changesPercentage: String? = nil,
        priceChanges: String? = nil,
        isFavourite: Bool? = nil
    ) {
        self.id = id == nil ? stock.id : id
        self.imageData = imageData == nil ? stock.imageData : imageData
        self.fullName = fullName == nil ? stock.fullName : fullName
        self.shortName = shortName == nil ? stock.shortName : shortName
        self.price = price == nil ? stock.price : price
        self.changesPercentage = changesPercentage == nil ? stock.changesPercentage : changesPercentage
        self.priceChanges = priceChanges == nil ? stock.priceChanges : priceChanges
        self.isFavourite = isFavourite == nil ? stock.isFavourite : isFavourite
    }
}
