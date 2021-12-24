//
//  CDCategory+CoreDataProperties.swift
//  
//
//  Created by Андрей Моисеев on 13.11.2021.
//
//

import Foundation
import CoreData


extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "CDCategory")
    }

    @NSManaged public var categoryId: Int64
    @NSManaged public var categoryName: String?
    @NSManaged public var image: String?
    @NSManaged public var categories: NSSet?
    
    var wrappedCategoryId: Int {
        return Int(categoryId)
    }

    var wrappedCategoryName: String {
        return categoryName ?? ""
    }
    
    var wrappedImage: String {
        return image ?? ""
    }
    
    var friendsArray: [CDEvent] {
        let set = categories as? Set<CDEvent> ?? []
        return set.sorted {
            $0.wrappedEventName < $1.wrappedEventName
        }
    }
}

// MARK: Generated accessors for categories
extension CDCategory {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CDEvent)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CDEvent)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}
