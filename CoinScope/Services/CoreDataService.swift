//
//  CoreDataService.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/30/1403 AP.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let container : NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error loading CoreData \(error)")
            }
        }
        getPortfolio()
    }
    
    func updatePortfolio(coin:CoinModel , amount : Double){
        if let updatingEntity = savedEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                update(entity: updatingEntity, NewAmount: amount)
            }else{
                delete(entity: updatingEntity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetche portfolio entities \(error)")
        }
    }
    
    private func add (coin:CoinModel , amount : Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        save()
        getPortfolio()
    }
    
    private func update (entity : PortfolioEntity , NewAmount : Double){
        entity.amount = NewAmount
        applyChanges()
    }
    
    private func delete (entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save (){
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving to CoreData \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
}
