//
//  NetworkManager.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 18.12.2021.
//

import Foundation

class NetworkService {
    
    var baseURL = "https://trainingapp-d0f45-default-rtdb.europe-west1.firebasedatabase.app/.json"
    
    func fethCategories(_ completion: @escaping (Result<[Categor], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let modell = try? JSONDecoder().decode(CategoriesData.self, from: data) {
                completion(.success(modell.categories))
            } else {
                print("error")
                completion(.failure(NSError()))
            }
        }
        task.resume()
    }
    
    func fethEvents(_ completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let modell = try? JSONDecoder().decode(EventsData.self, from: data) {
                completion(.success(modell.events))
            } else {
                print("error")
                completion(.failure(NSError()))
            }
        }
        task.resume()
    }
    
}
