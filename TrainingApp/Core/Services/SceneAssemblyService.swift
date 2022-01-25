//
//  SceneAssemblyService.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 17.01.2022.
//

import UIKit

protocol SceneAssemblable {
    func buildCategoriesModule() -> CategoriesViewController
    func buildCharityEventModule() -> CharityEventViewController
    func buildEventDetailsModule() -> EventDetailsViewController
}

final class SceneAssemblyService {
    
    private let networkService = NetworkService.network
    private let dataBase = DataBaseAdapter.dataBase
}

extension SceneAssemblyService: SceneAssemblable {
    
    func buildCategoriesModule() -> CategoriesViewController {
        
        let viewController = CategoriesViewController()
        let interactor = CategoriesInteractor(networkService: networkService, dataBase: dataBase)
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter(assemblyService: self)
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    func buildCharityEventModule() -> CharityEventViewController {
        
        let view = CharityEventViewController()
        let viewModel = CharityEventViewModel(networkService: networkService, dataBase: dataBase)

        view.viewModel = viewModel

        return view
    }
    
    func buildEventDetailsModule() -> EventDetailsViewController {
        
        let viewController = EventDetailsViewController()
        let presenter = EventDetailsPresenter(networkService: networkService, dataBase: dataBase)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
