//
//  CoreDataManager.swift
//  Inverstment
//
//  Created by Тася Галкина on 15.07.2025.
//

import CoreData
import UIKit

final class CoreDataManager {
    private var persistentContainer: NSPersistentContainer
    
    init() {
        let persistentContainer =  NSPersistentContainer(name: "Inverstment")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("failed to load Core Data stack: \(error)")
            }
        }
        
        self.persistentContainer = persistentContainer
    }
    
    func fetchStock(ticker: String? = nil, id: UUID? = nil) -> StockEntity? {
        guard ticker != nil || id != nil else {
            print("both are nil")
            return nil
        }
        
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<StockEntity> = StockEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        if let id = id {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as NSUUID)
        } else if let ticker = ticker {
            fetchRequest.predicate = NSPredicate(format: "shortName == %@", ticker)
        }
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch stock from Core Data: \(error)")
            return nil
        }
    }
    
    func saveStock(stock: StocksModel, imageData: Data?, context: NSManagedObjectContext? = nil) {
        let context = context ?? persistentContainer.viewContext
        let stockEntity = StockEntity(context: context)
        stockEntity.id = stock.id
        stockEntity.image = imageData
        stockEntity.fullName = stock.fullName
        stockEntity.shortName = stock.shortName
        stockEntity.price = stock.price
        stockEntity.changesPercentage = stock.changesPercentage
        stockEntity.priceChanges = stock.priceChanges
        stockEntity.isFavourite = stock.isFavourite ?? false
        
        do {
            try context.save()
            print("saved stock: \(stock.shortName)")
        } catch {
            print("failed to save stock to Core Data: \(error)")
        }
    }
    
    func fetchAllStocks() -> [StockEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<StockEntity> = StockEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("failed to fetch all stocks from CoreData: \(error)")
            return []
        }
    }
    
    func changeFavouriteStatus(id: UUID) -> Bool {
        let context = persistentContainer.viewContext
        guard let stockEntity = fetchStock(id: id) else {
            print("No stock found with ID: \(id)")
            return false
        }
        
        stockEntity.isFavourite.toggle()
        
        do {
            try context.save()
            print("updated status: \(stockEntity.shortName ?? "N/A") \(stockEntity.isFavourite)")
            return true
        } catch {
            print("failed to update favourite status in Core Data: \(error)")
            return false
        }
    }
}
