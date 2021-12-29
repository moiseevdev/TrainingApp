//
//  NetworkManager.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 18.12.2021.
//

import Foundation

final class URLSessionService: Networkable {
    
    var baseURL = "https://trainingapp-d0f45-default-rtdb.europe-west1.firebasedatabase.app/.json"
    
    func fethCategories(_ completion: @escaping (Result<[Categor], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let model = try? JSONDecoder().decode(CategoriesData.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(model.categories))
                }
            } else {
                completion(.failure(NSError()))
            }
        }
        task.resume()
    }
    
    func fethEvents(_ completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let model = try? JSONDecoder().decode(EventsData.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(model.events))
                }
            } else {
                completion(.failure(NSError()))
            }
        }
        task.resume()
    }
    
}
