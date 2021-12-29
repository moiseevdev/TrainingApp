//
//  MoyaService.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 28.12.2021.
//

import Foundation
import Moya

public enum TestMoya {
    case category
    case event
}

extension TestMoya: TargetType {
    public var baseURL: URL {
        URL(string: "https://moiseev.dev/api/trainingapp")!
    }

    public var path: String {
        switch self {
        case .category: return "/categories.json"
        case .event: return "/events.json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .category: return .get
        case .event: return .get
        }
    }

    public var task: Task {
        .requestPlain
    }

    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}


class MoyaService: Networkable {
    
    let provider = MoyaProvider<TestMoya>()
    
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
