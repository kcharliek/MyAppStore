//
//  SearchCoordinator.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


class SearchCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    private weak var navigationController: UINavigationController?
    private let factory: SearchViewFactory

    init(navigationController: UINavigationController?, factory: SearchViewFactory = DefaultSearchViewFactory()) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start() {
        let viewController = factory.makeSearchViewController()
        viewController.coordinator = self
        navigationController?.viewControllers = [viewController]
    }

}

extension SearchCoordinator {

    func showAppDetail(with app: App) {
        let coordinator = AppDetailCoordinator(navigationController: navigationController, app: app)
        childCoordinators.append(coordinator)
        coordinator.start()
    }

}
