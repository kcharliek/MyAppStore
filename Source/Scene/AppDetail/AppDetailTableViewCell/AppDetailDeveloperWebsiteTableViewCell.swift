//
//  AppDetailDeveloperWebsiteTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


private enum Design {

    static let font: UIFont = .systemFont(ofSize: 15, weight: .light)
    static let textColor: UIColor = .systemBlue

}

class AppDetailDeveloperWebsiteTableViewCell: BaseAppDetailTableViewCell {

    override func bind(model: AppDetailTableViewCellModel) {
        textLabel?.text = Text.developr_website.value
    }

    override func setupSubViews() {
        super.setupSubViews()

        textLabel?.textColor = Design.textColor
        textLabel?.font = Design.font
    }

}
