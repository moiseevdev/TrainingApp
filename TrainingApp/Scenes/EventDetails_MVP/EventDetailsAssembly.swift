//
//  EventDetailsAssembly.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 12.01.2022.
//

import Foundation
import UIKit

final class EventDetailsAssembly: NSObject {
    
    var eventId: Int?
    
    private let networkService = NetworkService.network
    private let dataBase = DataBaseAdapter.dataBase
    
    func configuredModule() -> UIViewController {
        
        let viewController = EventDetailsViewController()
        let presenter = EventDetailsPresenter(networkService: networkService, dataBase: dataBase)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        viewController.eventId = eventId
        
        return viewController
    }
}
