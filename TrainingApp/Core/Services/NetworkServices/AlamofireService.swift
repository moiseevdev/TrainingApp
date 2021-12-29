//
//  AlamofireService.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 24.12.2021.
//

import Alamofire

final class AlamofireService: Networkable {
    
    var baseURL = "https://trainingapp-d0f45-default-rtdb.europe-west1.firebasedatabase.app/.json"
    
    func fethCategories(_ completion: @escaping (Result<[Categor], Error>) -> Void) {
        AF.request(baseURL)
            .validate()
            .responseDecodable(of: CategoriesData.self) { (response) in
                if let model = response.value {
                    DispatchQueue.main.async {
                        completion(.success(model.categories))
                    }
                } else {
                    completion(.failure(NSError()))
                }
            }
    }
    
    func fethEvents(_ completion: @escaping (Result<[Event], Error>) -> Void) {
        AF.request(baseURL)
            .validate()
            .responseDecodable(of: EventsData.self) { (response) in
                if let model = response.value {
                    DispatchQueue.main.async {
                        completion(.success(model.events))
                    }
                } else {
                    completion(.failure(NSError()))
                }
            }
    }
}
