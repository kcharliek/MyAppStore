//
//  UILabelExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


extension UILabel {

    @IBInspectable var localizationKey: String? {
        get { text }
        set { text = newValue?.localized }
    }

}

extension UIButton {

    @IBInspectable var localizationKey: String? {
        get { titleLabel?.text }
        set { setTitle(newValue?.localized, for: .normal) }
    }

}
