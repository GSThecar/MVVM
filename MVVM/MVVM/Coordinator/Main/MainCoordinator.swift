//
//  MainCoordinator.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import UIKit

protocol MainCoordinatorType: CoordinatorType {
    func appearTab()
}

final class MainCoordinator: MainCoordinatorType {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var coordinatorChidren: [CoordinatorType]
    var navigationController: UINavigationController
    
    var category: CoordinatorCategory { .main }
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        coordinatorChidren = []
    }
    
    func start() {
        appearTab()
    }
    
    func appearTab() {
        let tabCoordinator = TabCoordinator(with: navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        coordinatorChidren.append(tabCoordinator)
    }
}

extension MainCoordinator: CoordinatorFinishDelegate {
    func coordinatorFinished(with child: CoordinatorType) {
        switch child.category {
        case .tabBarController:
            //TODO: Other Flow
            break
        default:
            break
        }
    }
    
    
}
