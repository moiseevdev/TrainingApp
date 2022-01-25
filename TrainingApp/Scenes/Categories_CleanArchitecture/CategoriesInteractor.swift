//
//  CategoriesInteractor.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 13.01.2022.
//

import Foundation

protocol CategoriesBusinessLogic {
    func makeRequest(request: CategoriesModel.Request.RequestType)
}

final class CategoriesInteractor {
    
    var presenter: CategoriesPresentationLogic?
    private var networkService: Networkable
    private var dataBase: Databaseing
    
    init(networkService: Networkable,
         dataBase: Databaseing) {
        self.networkService = networkService
        self.dataBase = dataBase
    }
}

extension CategoriesInteractor: CategoriesBusinessLogic {
    
    func makeRequest(request: CategoriesModel.Request.RequestType) {

        switch request {
        case .getCategories:
            networkService.fethCategories { [weak self] result in
                switch result {
                case .success(let networkResponse):
                    self?.presenter?.presentData(response: CategoriesModel.Response.ResponseType.presentNetworkResponse(categories: networkResponse))
                case .failure:
                    self?.dataBase.getCategories { result in
                        switch result {
                        case .success(let databaseResponse):
                            self?.presenter?.presentData(response: CategoriesModel.Response.ResponseType.presentDatabaseResponse(categories: databaseResponse))
                        case .failure:
                            print("error")
                        }
                    }
                }
            }
        }
    }
}
