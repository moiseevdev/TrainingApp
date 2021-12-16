//
//  RealmAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 06.12.2021.
//

import Foundation
import RealmSwift

class RealmAdapter {
    
    var realmManager = RealmManager()
    var categories: Results<Categor>!
    var events: Results<Event>!
    
    public func saveCategories() {
        let modelCategories = DataFromFile().modelCategories
        realmManager.saveCategoriesModel(model: modelCategories!)
        categories = self.realmManager.localRealm.objects(Categor.self)
    }
    
    public func saveEvents() {
        let modelEvents = DataFromFile().modelEvents
        self.realmManager.saveEventsModel(model: modelEvents!)
        self.events = self.realmManager.localRealm.objects(Event.self)
    }
    
}
