//
//  CDCategories+CoreDataProperties.swift
//  
//
//  Created by Андрей Моисеев on 13.11.2021.
//
//

import Foundation
import CoreData


extension CDCategories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategories> {
        return NSFetchRequest<CDCategories>(entityName: "CDCategories")
    }

    @NSManaged public var categoryID: Int16
    @NSManaged public var categoryName: String?
    @NSManaged public var image: String?
    @NSManaged public var categories: NSSet?
    
    var wrappedCategoryID: Int {
        return Int(categoryID)
    }

    var wrappedCategoryName: String {
        return categoryName ?? ""
    }
    
    var wrappedImage: String {
        return image ?? ""
    }
    
    var friendsArray: [CDEvents] {
        let set = categories as? Set<CDEvents> ?? []
        return set.sorted {
            $0.wrappedEventName < $1.wrappedEventName
        }
    }
}

// MARK: Generated accessors for categories
extension CDCategories {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CDEvents)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CDEvents)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}
