//
//  AppDetailCoordinator.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


class AppDetailCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    private weak var navigationController: UINavigationController?
    private let app: App
    private let factory: AppDetailViewFactory

    init(navigationController: UINavigationController?, app: App, factory: AppDetailViewFactory? = nil) {
        self.navigationController = navigationController
        self.app = app
        self.factory = factory ?? DefaultAppDetailViewFactory(app: app)
    }

    func start() {
        let viewController = factory.makeAppDetailViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

}
