//
//  MoyaService.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 28.12.2021.
//

import Foundation
import Moya

class MoyaService: Networkable {
    
    let provider = MoyaProvider<ObtainMoya>()
    
    func fethCategories(_ completion: @escaping (Result<[Categor], Error>) -> Void) {
        provider.request(.category) { result in
          switch result {
          case .success(let response):
            do {
                let model = try response.map(CategoriesData.self)
                DispatchQueue.main.async {
                    completion(.success(model.categories))
                }
            } catch {}
          case .failure:
              completion(.failure(NSError()))
          }
        }
    }

    
    func fethEvents(_ completion: @escaping (Result<[Event], Error>) -> Void) {
        provider.request(.event) { result in
          switch result {
          case .success(let response):
            do {
                let model = try response.map(EventsData.self)
                DispatchQueue.main.async {
                    completion(.success(model.events))
                }
            } catch {}
          case .failure:
              completion(.failure(NSError()))
          }
        }
    }
        
}
