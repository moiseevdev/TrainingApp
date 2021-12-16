//
//  Events.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 08.10.2021.
//

import Foundation

struct EventsData: Codable {
    let events: [Event]
}

struct Event: Codable {
    let eventId: Int
    let eventName: String
    let image: String
    let descriptionEvent: String
    let timeLeft: String
    let address: String
    let number: String
    let email: String
    let image1: String
    let image2: String
    let image3: String
    let description1: String
    let description2: String
    let website: String
}


