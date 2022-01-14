//
//  CharityEventAssembly.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 12.01.2022.
//

import Foundation
import UIKit

final class CharityEventAssembly: NSObject {
    
    let networkService = NetworkService.network
    let dataBase = DataBaseAdapter.dataBase
    
    func configuredModule() -> UIViewController {
        
        let view = CharityEventViewController()
        let viewModel = CharityEventViewModel(networkService: networkService, dataBase: dataBase)
        
        view.viewModel = viewModel
        
        return view
    }
}
