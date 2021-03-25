//
//  Coordinator.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import Foundation


protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }

    func start()

}
