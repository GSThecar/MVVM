//
//  MainCoordinator.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import UIKit

class MainCoordinator: CoordinatorType {
    
    var coordinatorChidren: [CoordinatorType]
    
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        coordinatorChidren = []
    }
    
    func start() {
        let gitHubRepositoryViewController = gitHubRepositoryViewController()
        gitHubRepositoryViewController.coordinator = self
        navigationController.pushViewController(gitHubRepositoryViewController, animated: true)
    }
    
    func detailRepository(with viewModel: WebViewViewModel) {
        let webViewViewController = webViewViewController(with: viewModel)
        webViewViewController.coordinator = self
        navigationController.pushViewController(webViewViewController, animated: true)
    }
    
    //Init ViewController
    
    private func gitHubRepositoryViewController() -> GithubRepositoryViewController {
        GithubRepositoryViewController.create(with: GithubViewModel(with: GithubService(), setting: GithubSetting()))
    }
    
    private func webViewViewController(with viewModel: WebViewViewModel) -> WebViewViewController {
        WebViewViewController.create(with: viewModel)
    }
}
