//
//  DataFromFile.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation

struct DataFromFile {
    let modelCategories = ReadJSONFromFile().readJSON(fileName: "categories", type: CategoriesData.self)?.categories
    let modelEvents = ReadJSONFromFile().readJSON(fileName: "events", type: EventsData.self)?.events
}
