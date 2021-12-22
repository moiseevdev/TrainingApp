//
//  NetworkModel.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 22.12.2021.
//

import Foundation

struct CategoryModel: Codable {
    let categoryID: Int?
    let categoryName: String?
    let image: String?
}

struct EventModel: Codable {
    let eventID: Int?
    let eventName: String?
    let image: String?
    let descriptionEvent: String?
    let timeLeft: String?
    let address: String?
    let number: String?
    let email: String?
    let image1: String?
    let image2: String?
    let image3: String?
    let description1: String?
    let description2: String?
    let website: String?
}
