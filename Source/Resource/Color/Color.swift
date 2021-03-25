//
//  Color.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit


enum Color {

    case defaultViewBackground
    case defaultTextColor
    case starRatingColor
    
    var value: UIColor {
        guard let color = UIColor(named: String(describing: self)) else {
            assertionFailure("Asset Color Not Found")
            return .black
        }
        return color
    }

}
