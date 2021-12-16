//
//  ReadJSONFromFile.swift
//  TraineeApp
//
//  Created by Андрей Моисеев on 11.10.2021.
//

import Foundation

class ReadJSONFromFile {
    
    func readJSON<T: Codable>(fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print(error)
            }
        }
        return nil
    }
    
}


