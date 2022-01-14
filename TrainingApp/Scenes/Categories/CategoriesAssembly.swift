//
//  CategoriesAssembly.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 13.01.2022.
//

import Foundation
import UIKit

class CategoriesAssembly: NSObject {
    
    private let networkService = NetworkService.network
    private let dataBase = DataBaseAdapter.dataBase
    
    func configuredModule() -> UIViewController {
        
        let viewController = CategoriesViewController()
        let interactor = CategoriesInteractor(networkService: networkService, dataBase: dataBase)
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
