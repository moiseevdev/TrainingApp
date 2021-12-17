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
    
    public func saveCategories() {
        let modelCategories = DataFromFile().modelCategories
        self.coreDataService.saveCategories(modelCategories: modelCategories)
        self.categories = self.coreDataService.fetchDataCDCategories()
    }
    
    public func saveEvents() {
        let modelEvents = DataFromFile().modelEvents
        self.coreDataService.saveEvents(modelEvents: modelEvents)
        self.events = self.coreDataService.fetchDataCDEvents()
    }


}
