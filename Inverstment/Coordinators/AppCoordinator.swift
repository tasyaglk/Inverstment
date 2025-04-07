//
//  AppCoordinator.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

private protocol CoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol? { get set }
    var childrenCoordinator: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    
    fileprivate var parentCoordinator: CoordinatorProtocol?
    fileprivate var childrenCoordinator: [CoordinatorProtocol] = []
    
    fileprivate var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToListOfStocks()
    }
    
    func goToListOfStocks() {
        let stocksVM = StocksVM()
        let stocksVC = StocksVC(stocksViewModel: stocksVM)
        stocksVM.coordinator = self
       
        navigationController.pushViewController(stocksVC, animated: false)
    }
}

