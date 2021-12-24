//
//  CoreDataAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation

final class CoreDataAdapter: Databaseing {
    
    var coreDataService = CoreDataService()

    func getCategories(_ completion: (Result<[CategoryModel], Error>) -> Void) {
        let categories = coreDataService.fetchDataCDCategories()
        let castResults = categories.map({ CategoryModel(categoryId: Int($0.categoryId),
                                                              categoryName: $0.categoryName,
                                                              image: $0.image) })
        completion(.success(castResults))
    }

    func getEvents(_ completion: (Result<[EventModel], Error>) -> Void) {
        let events = coreDataService.fetchDataCDEvents()
        let castResults = events.map({ EventModel(eventId: Int($0.eventId),
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
