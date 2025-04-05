//
//  AppCoordinator.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var childrenCoordinator: [CoordinatorProtocol] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("hi")
        goToListOfStocks()
    }
    
    func goToListOfStocks() {
        let stocksVC = StocksVC()
        let stocksVM = StocksVM.init()
        stocksVM.coordinator = self
        stocksVC.viewModel = stocksVM
       
        navigationController.pushViewController(stocksVC, animated: false)
    }
}

