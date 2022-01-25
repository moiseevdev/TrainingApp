//
//  CategoriesRouter.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 13.01.2022.
//

import UIKit

protocol CategoriesRoutingLogic {
    
}

final class CategoriesRouter: NSObject, CategoriesRoutingLogic {
    
    weak var viewController: CategoriesViewController?
    
    private let assemblyService: SceneAssemblable
    
    init(assemblyService: SceneAssemblable) {
        self.assemblyService = assemblyService
    }
    
    // MARK: Routing
    
}
