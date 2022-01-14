//
//  CharityEventViewModel.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 10.01.2022.
//

import Foundation

protocol CharityEventViewModelProtocol {
    var events: [EventModel] { get set }
    var reloadCollectionViewData: (() -> ())? { get set }
    func numberOfRows() -> Int
    func fetchEvents()
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CharityEventCellViewModelType?
}

final class CharityEventViewModel: CharityEventViewModelProtocol {
    
    private var networkService: Networkable
    private var dataBase: Databaseing
    
    var events: [EventModel] = [] {
        didSet {
            self.reloadCollectionViewData?()
        }
    }
    
    var reloadCollectionViewData: (() -> ())?
    
    init(networkService: Networkable,
         dataBase: Databaseing) {
        self.networkService = networkService
        self.dataBase = dataBase
    }
    
    func numberOfRows() -> Int {
        return events.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CharityEventCellViewModelType? {
        let events = events[indexPath.item]
        return CharityEventCellViewModel(events: events)
    }
    
    func fetchEvents() {
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
                        print(Error.self)
                    }
                }
            }
        }
    }
}
