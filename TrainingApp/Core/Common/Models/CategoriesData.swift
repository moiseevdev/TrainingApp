//
//  Categories.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 08.10.2021.
//

import Foundation
import RealmSwift

struct CategoriesData: Codable {
    let categories: [Categor]
}

class Categor: Object, Codable {
    @Persisted var categoryID: Int
    @Persisted var categoryName: String
    @Persisted var image: String
}
