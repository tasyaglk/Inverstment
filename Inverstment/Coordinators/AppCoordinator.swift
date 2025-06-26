//
//  AppCoordinator.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    private(set) var parentCoordinator: CoordinatorProtocol?
    private(set) var childrenCoordinator: [CoordinatorProtocol] = []
    
    private(set) var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToListOfStocks()
    }
    
    func goToListOfStocks() {
        let stocksVM = StocksVM(coordinator: self)
        let stocksVC = StocksVC(stocksViewModel: stocksVM)
        stocksVM.fetchStocks { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("error \(error.errorDescription ?? "error")")
            }
        }
        navigationController.pushViewController(stocksVC, animated: false)
    }
}

