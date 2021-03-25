//
//  AppTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


private enum Design {

    static let placeholderColor: UIColor = .lightGray
}

struct AppTableViewCellModel {

    var app: App

}

class AppTableViewCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var iconView: AppIconView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?

    @IBOutlet weak var ratingStackView: UIStackView?
    @IBOutlet weak var ratingView: StarRatingView?
    @IBOutlet weak var ratingCountLabel: UILabel?

    @IBOutlet weak var purchaseButton: AppPurchaseButton?
    @IBOutlet weak var inAppPurchaseNoticeLabel: UILabel?

    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    func bind(model: AppTableViewCellModel) {
        iconView?.set(model: model.app)

        titleLabel?.text = model.app.trackName

        descriptionLabel?.text = model.app.genres?.first

        purchaseButton?.isHidden = false
        purchaseButton?.set(model: model.app)

        let hasRating = (model.app.userRatingCount.orZero > 0) && (model.app.averageUserRating.orZero > 0)
        ratingStackView?.isHidden = (hasRating == false)
        ratingCountLabel?.text = model.app.userRatingCount?.humanReadableText
        model.app.averageUserRating.map { ratingView?.setRating($0) }

        inAppPurchaseNoticeLabel?.isHidden = false
        inAppPurchaseNoticeLabel?.text = Text.in_app_purchase.value
    }

}

// MARK: - Private

private extension AppTableViewCell {

    func reset() {
        iconView?.reset()

        titleLabel?.text = ""
        descriptionLabel?.text = ""

        ratingStackView?.isHidden = true
        purchaseButton?.isHidden = true
        inAppPurchaseNoticeLabel?.isHidden = true
    }

}
