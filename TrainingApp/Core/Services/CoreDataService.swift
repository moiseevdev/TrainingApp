//
//  CoreDataStack.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 05.11.2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {

    static let shared = CoreDataService()
    var categories = [CDCategories]()
    var events = [CDEvents]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrainingApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    lazy var fetchRequestCategories: NSFetchRequest<CDCategories> = CDCategories.fetchRequest()
    lazy var fetchRequestEvents: NSFetchRequest<CDEvents> = CDEvents.fetchRequest()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataStack.persistentContainer.viewContext
    }

    func fetchDataCDCategories() -> [CDCategories] {
        let request: NSFetchRequest<CDCategories> = CDCategories.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [CDCategories]()
    }
    
//    func getData(_ completion: (Result<[ModelTest], Error>) -> Void) {
//        let request: NSFetchRequest<CDCategories> = CDCategories.fetchRequest()
//        let results = (try? persistentContainer.viewContext.fetch(request)) ?? [CDCategories]()
//        let castResults = results.map({ ModelTest(categoryID: Int($0.categoryID),
//                                                   categoryName: $0.categoryName!,
//                                                   image: $0.image!) })
//        completion(.success(castResults))
//    }
    
    func fetchDataCDEvents() -> [CDEvents] {
        let request: NSFetchRequest<CDEvents> = CDEvents.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [CDEvents]()
    }
    
    func saveCategories(modelCategories: [Categor]?) {
        do {
            let fetchRequest = self.fetchRequestCategories
            let context = self.getContext()
            let categories = try context.fetch(fetchRequest)
            if categories.count == 0 {
                context.performAndWait {
                    modelCategories?.forEach { category in
                        let cdCategories = CDCategories(context: context)
                        cdCategories.categoryID = Int16(category.categoryID)
                        cdCategories.categoryName = category.categoryName
                        cdCategories.image = category.image
                        try? context.save()
                    }
                }
                self.categories = try context.fetch(fetchRequest)
            }
            else {
                self.categories = try context.fetch(fetchRequest)
            }
            if context.hasChanges {
                try? context.save()
            }
        } catch {}
    }
    
    func saveEvents(modelEvents: [Event]?) {
        do {
            let fetchRequest = self.fetchRequestEvents
            let context = self.getContext()
            let events = try context.fetch(fetchRequest)
            if events.count == 0 {
                context.performAndWait {
                    modelEvents?.forEach { event in
                        let cdEvent = CDEvents(context: context)
                        cdEvent.eventId = Int16(event.eventID)
                        cdEvent.eventName = event.eventName
                        cdEvent.image = event.image
                        cdEvent.descriptionEvent = event.descriptionEvent
                        cdEvent.timeLeft = event.timeLeft
                        cdEvent.address = event.address
                        cdEvent.number = event.number
                        cdEvent.email = event.email
                        cdEvent.image1 = event.image1
                        cdEvent.image2 = event.image2
                        cdEvent.image3 = event.image3
                        cdEvent.description1 = event.description1
                        cdEvent.description2 = event.description2
                        cdEvent.website = event.website
                        try? context.save()
                    }
                }
                self.events = try context.fetch(fetchRequest)
            }
            else {
                self.events = try context.fetch(fetchRequest)
                
            }
            if context.hasChanges {
                try? context.save()
            }
        } catch {}
    }

}
