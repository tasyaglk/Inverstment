//
//  CoordinatorProtocol.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

protocol CoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol? { get set }
    var childrenCoordinator: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
