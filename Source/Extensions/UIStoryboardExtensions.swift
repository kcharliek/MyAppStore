//
//  UIStoryboardExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


enum StoryboardType {

    case main

    var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }

}

extension UIStoryboard {

    class func instantiateViewController<T: UIViewController>(_ type: T.Type, storyboardType: StoryboardType = .main) -> T {
        let storyboard = UIStoryboard(name: storyboardType.name, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: type.className) as? T else {
            assertionFailure("UIStoryboard Instantiate ViewController Failed")
            return T.init()
        }
        return vc
    }

}
