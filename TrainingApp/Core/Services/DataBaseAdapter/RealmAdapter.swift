//
//  RealmAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation
import RealmSwift

class RealmAdapter {
    
    var realmService = RealmService()
    var categories: Results<Categor>!
    var events: Results<Event>!
    
    public func saveCategories() {
        let modelCategories = DataFromFile().modelCategories
        realmService.saveCategoriesModel(model: modelCategories!)
        categories = self.realmService.localRealm.objects(Categor.self)
    }
    
    public func saveEvents() {
        let modelEvents = DataFromFile().modelEvents
        realmService.saveEventsModel(model: modelEvents!)
        events = self.realmService.localRealm.objects(Event.self)
    }
    
}
