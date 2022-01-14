//
//  CategoriesInteractor.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 13.01.2022.
//

import Foundation

protocol CategoriesBusinessLogic {
    func makeRequest(request: Categories.Model.Request.RequestType)
    func setupData()
}

final class CategoriesInteractor {
    
    var presenter: CategoriesPresentationLogic?
    private var networkService: Networkable
    private var dataBase: Databaseing
    
    var categories: [CategoryModel] = [] {
        didSet {
            setupData()
        }
    }
    
    init(networkService: Networkable,
         dataBase: Databaseing) {
        self.networkService = networkService
        self.dataBase = dataBase
    }
    
}

extension CategoriesInteractor: CategoriesBusinessLogic {
    
    func makeRequest(request: Categories.Model.Request.RequestType) {

        switch request {
        case .getCategories:
            networkService.fethCategories { [weak self] result in
                switch result {
                case .success(let networkResponse):
                    self?.categories = networkResponse.map({ CategoryModel(categoryId: Int($0.categoryId),
                                                                           categoryName: $0.categoryName,
                                                                           image: $0.image) })
                case .failure:
                    self?.dataBase.getCategories { result in
                        switch result {
                        case .success(let coredataResponse):
                            self?.categories = coredataResponse
                        case .failure:
                            print("error")
                        }
                    }
                }
            }
        }
    }
    
    func setupData() {
        presenter?.presentData(response: Categories.Model.Response.ResponseType.presentCategories(categories: categories))
    }
}
