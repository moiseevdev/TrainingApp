//
//  EventDetailsPresenter.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 11.01.2022.
//

import Foundation

protocol EventDetailsProtocol {
    var events: [EventModel] { get set }
    func fethEvents()
}

final class EventDetailsPresenter {
    
    weak var viewController: EventDetailsViewProtocol!
    
    private let networkService: Networkable
    private let dataBase: Databaseing
    
    var events: [EventModel] = [] {
        didSet {
            viewController.setuphData(data: events)
        }
    }
    
    init(networkService: Networkable,
         dataBase: Databaseing) {
        self.networkService = networkService
        self.dataBase = dataBase
    }
}

extension EventDetailsPresenter: EventDetailsProtocol {
    
    func fethEvents() {
        networkService.fethEvents { [weak self] result in
            switch result {
            case .success(let networkResponse):
                self?.events = networkResponse.map({ EventModel(eventId: $0.eventId,
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
            case .failure:
                self?.dataBase.getEvents { result in
                    switch result {
                    case .success(let coredataResponse):
                        self?.events = coredataResponse
                    case .failure:
                        self?.viewController.showErrorAlert()
                    }
                }
            }
        }
    }
}
