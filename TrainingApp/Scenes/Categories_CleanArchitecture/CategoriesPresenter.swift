//
//  CategoriesPresenter.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 13.01.2022.
//

import UIKit

protocol CategoriesPresentationLogic {
    func presentData(response: CategoriesModel.Response.ResponseType)
}

final class CategoriesPresenter {
    
    weak var viewController: CategoriesDisplayLogic?
    
}

extension CategoriesPresenter: CategoriesPresentationLogic {
    
    func presentData(response: CategoriesModel.Response.ResponseType) {
        
        switch response {
        case .presentNetworkResponse(categories: let categories):
            let categories = categories.map({ CategoryModel(categoryId: Int($0.categoryId),
                                           categoryName: $0.categoryName,
                                           image: $0.image) })
            viewController?.displayData(viewModel: .displayNetworkResponse(categories: categories))
        case .presentDatabaseResponse(categories: let categories):
            viewController?.displayData(viewModel: .displayDatabaseResponse(categories: categories))
        }
    }
}
