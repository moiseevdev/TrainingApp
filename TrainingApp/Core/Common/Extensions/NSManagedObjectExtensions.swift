//
//  NsExtensions.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 16.12.2021.
//

import Foundation
import CoreData

public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
