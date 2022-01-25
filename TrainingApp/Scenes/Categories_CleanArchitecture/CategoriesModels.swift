//
//  CategoriesModels.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 14.01.2022.
//

import Foundation

enum CategoriesModel {
    
    struct Request {
        enum RequestType {
            case getCategories
        }
    }
    struct Response {
        enum ResponseType {
            case presentNetworkResponse(categories: [Categor])
            case presentDatabaseResponse(categories: [CategoryModel])
        }
    }
    struct ViewModel {
        enum ViewModelData {
            case displayNetworkResponse(categories: [CategoryModel])
            case displayDatabaseResponse(categories: [CategoryModel])
        }
    }
    
}
