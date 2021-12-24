//
//  File.swift
//  TrainingApp
//
//  Created by Андрей Моисеев on 23.12.2021.
//

import Foundation

protocol Networkable1 {
    func method() -> [String]
}

class NetworkService1: Networkable1 {

    func method() -> [String] {
        print(#function)
        return []
    }
}

protocol InteractorProtocol {
    func getSomthing()
}

class Interactor: InteractorProtocol {
    let networkService: Networkable1

    init(networkService: Networkable1) {
        self.networkService = networkService
    }

    func getSomthing() {
        networkService.method()
        //
        //
    }
}

class ViewController {

    var interactor: InteractorProtocol!

    init() {
        interactor.getSomthing()
    }
}

class Test {

    init() {
        let viewController = ViewController()
        let networkService = AlamofireServicee()
        let interactor = Interactor(networkService: networkService)
        viewController.interactor = interactor
    }

}

class AlamofireServicee: Networkable1 {
    func method() -> [String] {
        //
        //
        return []
    }
}
