//
//  CoreDataStack.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 05.11.2021.
//

import CoreData
import UIKit

final class CoreDataService {

    static let shared = CoreDataService()
    var categories = [CDCategory]()
    var events = [CDEvent]()
    
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
    
    lazy var fetchRequestCategories: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
    lazy var fetchRequestEvents: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()

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

    func fetchDataCDCategories() -> [CDCategory] {
        let modelCategories = DataFromFile.modelCategories
        saveCategories(modelCategories: modelCategories)
        let request: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [CDCategory]()
    }
    
    func fetchDataCDEvents() -> [CDEvent] {
        let modelEvents = DataFromFile.modelEvents
        saveEvents(modelEvents: modelEvents)
        let request: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [CDEvent]()
    }
    
    func saveCategories(modelCategories: [Categor]?) {
        DispatchQueue.main.async {
            do {
                let fetchRequest = self.fetchRequestCategories
                let context = self.getContext()
                let categories = try context.fetch(fetchRequest)
                if categories.count == 0 {
                    context.performAndWait {
                        modelCategories?.forEach { category in
                            let cdCategory = CDCategory(context: context)
                            cdCategory.categoryId = Int64(category.categoryId)
                            cdCategory.categoryName = category.categoryName
                            cdCategory.image = category.image
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
        
    }
    
    func saveEvents(modelEvents: [Event]?) {
        DispatchQueue.main.async {
            do {
                let fetchRequest = self.fetchRequestEvents
                let context = self.getContext()
                let events = try context.fetch(fetchRequest)
                if events.count == 0 {
                    context.performAndWait {
                        modelEvents?.forEach { event in
                            let cdEvent = CDEvent(context: context)
                            cdEvent.eventId = Int64(event.eventId)
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
}
