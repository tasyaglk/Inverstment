//
//  StockEntity+CoreDataProperties.swift
//  Inverstment
//
//  Created by Тася Галкина on 15.07.2025.
//
//

import Foundation
import CoreData


extension StockEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockEntity> {
        return NSFetchRequest<StockEntity>(entityName: "StockEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var price: String?
    @NSManaged public var changesPercentage: String?
    @NSManaged public var priceChanges: String?
    @NSManaged public var isFavourite: Bool

}

extension StockEntity : Identifiable {

}
