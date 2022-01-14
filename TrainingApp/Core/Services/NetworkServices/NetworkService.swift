//
//  NetworkService.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 24.12.2021.
//

import Foundation

// MARK: - Networkable
protocol Networkable {
    
    func fethCategories(_ completion: @escaping (Result<[Categor], Error>) -> Void)
    func fethEvents(_ completion: @escaping (Result<[Event], Error>) -> Void)
}

// MARK: - NetworkService
final class NetworkService {
    
    // Choice of network layer: URLSession, Alamofire or Moya
    static var network: Networkable = URLSessionService()
}
