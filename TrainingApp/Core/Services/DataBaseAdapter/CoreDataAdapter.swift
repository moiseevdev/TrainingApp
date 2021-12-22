//
//  CoreDataAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation

class CoreDataAdapter {
    
    var coreDataService = CoreDataService()
    var categories: Array<CDCategories> = []
    var events: Array<CDEvents> = []
    
    func getCategories(_ completion: (Result<[CategoryModel], Error>) -> Void) {
        let modelCategories = DataFromFile.modelCategories
        DispatchQueue.main.async {
            self.coreDataService.saveCategories(modelCategories: modelCategories)
        }
        self.categories = self.coreDataService.fetchDataCDCategories()
        let castResults = self.categories.map({ CategoryModel(categoryID: Int($0.categoryID),
                                                              categoryName: $0.categoryName,
                                                              image: $0.image) })
        completion(.success(castResults))
    }
    
    func getEvents(_ completion: (Result<[EventModel], Error>) -> Void) {
        let modelEvents = DataFromFile.modelEvents
        DispatchQueue.main.async {
            self.coreDataService.saveEvents(modelEvents: modelEvents)
        }
        self.events = self.coreDataService.fetchDataCDEvents()
        let castResults = self.events.map({ EventModel(eventID: Int($0.eventId),
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
