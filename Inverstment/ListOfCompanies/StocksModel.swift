//
//  StocksModel.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import Foundation

struct StocksModel {
    
    let id: Int?
    let imageURL: String?
    let fullName: String?
    let shortName: String?
    let price: String?
    let priceChanges: String?
    let isFavourite: Bool?
    
    init(id: Int?, imageURL: String?, fullName: String?, shortName: String?, price: String?, priceChanges: String?, isFavourite: Bool?) {
        self.id = id
        self.imageURL = imageURL
        self.fullName = fullName
        self.shortName = shortName
        self.price = price
        self.priceChanges = priceChanges
        self.isFavourite = isFavourite
    }
    
    init(
        stock: StocksModel,
        id: Int? = nil,
        imageURL: String? = nil,
        fullName: String? = nil,
        shortName: String? = nil,
        price: String? = nil,
        priceChanges: String? = nil,
        isFavourite: Bool? = nil
    ) {
        self.id = id == nil ? stock.id : id
        self.imageURL = imageURL == nil ? stock.imageURL : imageURL
        self.fullName = fullName == nil ? stock.fullName : fullName
        self.shortName = shortName == nil ? stock.shortName : shortName
        self.price = price == nil ? stock.price : price
        self.priceChanges = priceChanges == nil ? stock.priceChanges : priceChanges
        self.isFavourite = isFavourite == nil ? stock.isFavourite : isFavourite
    }
}
