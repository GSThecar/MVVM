//
//  TabCoordinator.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/09.
//

import UIKit

protocol TabCoordinatorType: CoordinatorType {
    var tabBarController: UITabBarController { get set }
    
    func select(with category: TabCategory)
    func current() -> TabCategory
}

final class TabCoordinator: TabCoordinatorType {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var coordinatorChidren: [CoordinatorType]
    
    var navigationController: UINavigationController
    
    var category: CoordinatorCategory { .tabBarController }
    
    var tabBarController: UITabBarController
    
    func start() {
        tabBarController.viewControllers = TabCategory.all.map { viewController(each: $0) }
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        coordinatorChidren = []
        self.tabBarController = .init()
    }
    
    func select(with category: TabCategory) {
        tabBarController.selectedIndex = category.rawValue
    }
    
    func current() -> TabCategory {
        let category = TabCategory(rawValue: tabBarController.selectedIndex)
        return category ?? .gitHubRepository
    }
    
    private func viewController(each category: TabCategory) -> UINavigationController {
        let navigationController = UINavigationController()
        
        
        switch category {
        case .gitHubRepository:
            let gitHubRepositoryViewController = gitHubRepositoryViewController()
            gitHubRepositoryViewController.coordinator = self
            navigationController.pushViewController(gitHubRepositoryViewController, animated: true)
        }
        
        return navigationController
    }
    
    func detailRepository(with viewModel: WebViewViewModel) {
        let webViewViewController = webViewViewController(with: viewModel)
        webViewViewController.coordinator = self
        navigationController.pushViewController(webViewViewController, animated: true)
    }
    
    private func gitHubRepositoryViewController() -> GithubRepositoryViewController {
        GithubRepositoryViewController.create(with: GithubViewModel(with: GithubService(), setting: GithubSetting()))
    }
    
    private func webViewViewController(with viewModel: WebViewViewModel) -> WebViewViewController {
        WebViewViewController.create(with: viewModel)
    }
    
}
