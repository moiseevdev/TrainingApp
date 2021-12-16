//
//  CoreDataAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation

class CoreDataAdapter {
    
    var coreDataStack = CoreDataStack()
    var categories: Array<CDCategories> = []
    var events: Array<CDEvents> = []
    
    public func saveCategories() {
        let modelCategories = DataFromFile().modelCategories
        self.coreDataStack.saveCategories(modelCategories: modelCategories)
        self.categories = self.coreDataStack.fetchDataCDCategories()
    }
    
    public func saveEvents() {
        let modelEvents = DataFromFile().modelEvents
        self.coreDataStack.saveEvents(modelEvents: modelEvents)
        self.events = self.coreDataStack.fetchDataCDEvents()
    }


}
