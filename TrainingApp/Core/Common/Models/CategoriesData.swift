//
//  Categories.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 08.10.2021.
//

import Foundation

struct CategoriesData: Codable {
    let categories: [Categor]
}

struct Categor: Codable {
    let categoryID: Int
    let categoryName: String
    let image: String
}



