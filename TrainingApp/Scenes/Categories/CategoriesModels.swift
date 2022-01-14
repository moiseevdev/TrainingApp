//
//  CategoriesModels.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 14.01.2022.
//

import Foundation

enum Categories {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getCategories
            }
        }
        struct Response {
            enum ResponseType {
                case presentCategories(categories: [CategoryModel])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayCategories(categoriesViewModel: [CategoryModel])
            }
        }
    }
}
