//
//  AppDetailDeveloperTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


class AppDetailDeveloperTableViewCell: BaseAppDetailTableViewCell {

    @IBOutlet weak var developerNameLabel: UILabel?
    @IBOutlet weak var developerLabel: UILabel?

    override func bind(model: AppDetailTableViewCellModel) {
        developerNameLabel?.text = model.app.artistName
        developerLabel?.text = Text.developer.value
    }

}
