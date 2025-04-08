//
//  CoordinatorProtocol.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

protocol CoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol? { get }
    var childrenCoordinator: [CoordinatorProtocol] { get }
    var navigationController: UINavigationController { get }
    
    func start()
}
