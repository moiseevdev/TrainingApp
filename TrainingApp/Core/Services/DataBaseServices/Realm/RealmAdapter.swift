//
//  RealmAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation
import RealmSwift

class RealmAdapter: Databaseing {
    
    var realmService = RealmService()
    
    func getCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        let modelCategories = DataFromFile.modelCategories
        realmService.saveCategoriesModel(model: modelCategories!)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.realmService.categories = self.realmService.localRealm.objects(Categor.self)
            let castResults = Array(self.realmService.categories).map({ CategoryModel(categoryId: Int($0.categoryId),
                                                                                      categoryName: $0.categoryName,
                                                                                      image: $0.image) })
            completion(.success(castResults))
        }
        
        
        
    }
    
    func getEvents(_ completion: @escaping (Result<[EventModel], Error>) -> Void) {
        let modelEvents = DataFromFile.modelEvents
        realmService.saveEventsModel(model: modelEvents!)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.realmService.events = self.realmService.localRealm.objects(Event.self)
            let castResults = Array(self.realmService.events).map({ EventModel(eventId: Int($0.eventId),
                                                                               eventName: $0.eventName,
                                                                               image: $0.image,
                                                                               descriptionEvent: $0.descriptionEvent,
                                                                               timeLeft: $0.timeLeft,
                                                                               address: $0.address,
                                                                               number: $0.number,
                                                                               email: $0.email,
                                                                               image1: $0.image1,
                                                                               image2: $0.image2,
                                                                               image3: $0.image3,
                                                                               description1: $0.description1,
                                                                               description2: $0.description2,
                                                                               website: $0.website) })
            completion(.success(castResults))
        }
    }
}
