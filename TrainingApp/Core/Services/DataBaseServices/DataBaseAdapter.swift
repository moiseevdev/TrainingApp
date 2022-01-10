//
//  DataBaseAdapter.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 02.12.2021.
//

import Foundation

// MARK: - Databaseing
protocol Databaseing {
    func getCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getEvents(_ completion: @escaping (Result<[EventModel], Error>) -> Void)
}

class DataBaseAdapter {
    
    static let dataBase: Databaseing = CoreDataAdapter()
}
