//
//  Events.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 08.10.2021.
//

import Foundation
import RealmSwift

struct EventsData: Codable {
    let events: [Event]
}

class Event: Object, Codable {
    @Persisted var eventId: Int
    @Persisted var eventName: String
    @Persisted var image: String
    @Persisted var descriptionEvent: String
    @Persisted var timeLeft: String
    @Persisted var address: String
    @Persisted var number: String
    @Persisted var email: String
    @Persisted var image1: String
    @Persisted var image2: String
    @Persisted var image3: String
    @Persisted var description1: String
    @Persisted var description2: String
    @Persisted var website: String
}
