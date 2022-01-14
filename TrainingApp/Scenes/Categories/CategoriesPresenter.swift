//
//  CategoriesPresenter.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 13.01.2022.
//

import UIKit

protocol CategoriesPresentationLogic {
    func presentData(response: Categories.Model.Response.ResponseType)
}

final class CategoriesPresenter {
    
    weak var viewController: CategoriesDisplayLogic?
    
}

extension CategoriesPresenter: CategoriesPresentationLogic {
    
    func presentData(response: Categories.Model.Response.ResponseType) {
        
        switch response {
        case .presentCategories(let categories):
            viewController?.displayData(viewModel: Categories.Model.ViewModel.ViewModelData.displayCategories(categoriesViewModel: categories))
        }
    }
}
