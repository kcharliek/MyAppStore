//
//  AppDelegate.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = UINavigationController()
        window?.rootViewController = rootViewController

        coordinator = ApplicationCoordinator(rootViewController: rootViewController, launchOptions: launchOptions)
        coordinator?.start()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        try? CoreDataWrapper.shared.saveContext()
    }

}
