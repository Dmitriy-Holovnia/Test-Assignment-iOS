//
//  PersistentManager.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//

import Foundation
import CoreData

final class PersistentManager {
    
    static let shared = PersistentManager()
    
    func createNewCard(card: Card, completion: @escaping (Error?) -> Void) {
        persistentContainer.performBackgroundTask { (context) in
            let newCard = CardMO(context: context)
            newCard.number = Int64(card.number)
            
            do {
                try context.save()
                completion(nil)
            } catch let error {
                completion(error)
            }
            
        }
    }
    
    func getCards(completion: @escaping (Result<[Card], Error>) -> ()) {
        persistentContainer.performBackgroundTask { [weak self] (context) in
            guard let self = self else { return }
            
            let request: NSFetchRequest<CardMO> = CardMO.fetchRequest()
            
            do {
                let result = try context.fetch(request)
                let cards = self.parseCards(cards: result)
                completion(.success(cards))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func parseCards(cards: [CardMO]) -> [Card] {
        var result: [Card] = []
        for card in cards {
            guard let cardType = CardType(number: "\(card.number)".first) else { continue }
            let newCard = Card(number: Int(card.number), type: cardType)
            result.append(newCard)
        }
        return result
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "CardModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


