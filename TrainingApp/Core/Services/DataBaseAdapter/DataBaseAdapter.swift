//
//  DataBaseAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 02.12.2021.
//

import Foundation

// MARK: - Databaseing
protocol Databaseing {
    func getCategories(_ completion: (Result<[CategoryModel], Error>) -> Void)
    func getEvents(_ completion: (Result<[EventModel], Error>) -> Void)
}

class DataBaseAdapter {
    
    static let dataBase: Databaseing = CoreDataAdapter()
}
