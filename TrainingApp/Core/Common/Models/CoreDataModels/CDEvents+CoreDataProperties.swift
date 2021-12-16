//
//  CDEvents+CoreDataProperties.swift
//  
//
//  Created by Андрей Моисеев on 13.11.2021.
//
//

import Foundation
import CoreData


extension CDEvents {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEvents> {
        return NSFetchRequest<CDEvents>(entityName: "CDEvents")
    }

    @NSManaged public var address: String?
    @NSManaged public var description1: String?
    @NSManaged public var description2: String?
    @NSManaged public var descriptionEvent: String?
    @NSManaged public var email: String?
    @NSManaged public var eventId: Int16
    @NSManaged public var eventName: String?
    @NSManaged public var image: String?
    @NSManaged public var image1: String?
    @NSManaged public var image2: String?
    @NSManaged public var image3: String?
    @NSManaged public var number: String?
    @NSManaged public var timeLeft: String?
    @NSManaged public var website: String?
    @NSManaged public var categories: NSSet?
    
    var wrappedAddress: String {
        return address ?? ""
    }

    var wrappedDescription1: String {
        return description1 ?? ""
    }
    
    var wrappedDescription2: String {
        return description2 ?? ""
    }
    
    var wrappedDescriptionEvent: String {
        return descriptionEvent ?? ""
    }
    
    var wrappedEmail: String {
        return email ?? ""
    }
    
    var wrappedeventId: Int {
        return Int(eventId)
    }
    
    var wrappedEventName: String {
        return eventName ?? ""
    }
    
    var wrappedImage: String {
        return image ?? ""
    }
    
    var wrappedImage1: String {
        return image1 ?? ""
    }
    
    var wrappedImage2: String {
        return image2 ?? ""
    }
    
    var wrappedImage3: String {
        return image3 ?? ""
    }
    
    var wrappedNumber: String {
        return number ?? ""
    }
    
    var wrappedTimeLeft: String {
        return timeLeft ?? ""
    }
    
    var wrappedWebsite: String {
        return website ?? ""
    }
    
    // тут еще один блок

    var friendsArray: [CDCategories] {
        let set = categories as? Set<CDCategories> ?? []
        return set.sorted {
            $0.wrappedCategoryName < $1.wrappedCategoryName
        }
    }
}

// MARK: Generated accessors for categories
extension CDEvents {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CDCategories)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CDCategories)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}
