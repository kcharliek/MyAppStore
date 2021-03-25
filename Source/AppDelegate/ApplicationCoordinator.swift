//
//  ApplicationCoordinator.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


class ApplicationCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.rootViewController = rootViewController
        self.launchOptions = launchOptions
    }

    func start() {
        showSearch()
    }

}

extension ApplicationCoordinator {
    
    func showSearch() {
        let coordinator = SearchCoordinator(navigationController: rootViewController, factory: DefaultSearchViewFactory())
        childCoordinators.append(coordinator)
        coordinator.start()
    }

}
