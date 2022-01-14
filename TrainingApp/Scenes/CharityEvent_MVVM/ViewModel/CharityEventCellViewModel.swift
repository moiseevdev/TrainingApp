//
//  CharityEventCellViewModel.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 11.01.2022.
//

import Foundation

final class CharityEventCellViewModel: CharityEventCellViewModelType {
    
    private var events: EventModel
    
    var titleNameLabel: String {
        return events.eventName ?? ""
    }
    
    var titleImage: String {
        return events.image ?? ""
    }
    
    var descriptionEventLabel: String {
        return events.descriptionEvent ?? ""
    }
    
    var timeLeftLabel: String {
        return events.timeLeft ?? ""
    }
    
    init(events: EventModel) {
        self.events = events
    }
}
