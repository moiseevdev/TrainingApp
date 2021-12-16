//
//  RealmManager.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 01.12.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    let localRealm = try! Realm()
    
    var categories: Results<Categor>!
    var events: Results<Event>!
    
    func saveCategoriesModel(model: [Categor]) {
        try! localRealm.write {
            localRealm.deleteAll()
            localRealm.add(model)
        }
    }
    
    func saveEventsModel(model: [Event]) {
        try! localRealm.write {
            localRealm.deleteAll()
            localRealm.add(model)
        }
    }
    
}
