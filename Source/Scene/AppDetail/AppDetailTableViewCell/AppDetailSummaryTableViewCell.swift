//
//  AppDetailSummaryTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


class AppDetailSummaryTableViewCell: BaseAppDetailTableViewCell {

    // Rating
    @IBOutlet weak var ratingContainerView: UIView?
    @IBOutlet weak var ratingTitleLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var ratingView: StarRatingView?

    // Age
    @IBOutlet weak var ageTitleLabel: UILabel?
    @IBOutlet weak var ageLabel: UILabel?
    @IBOutlet weak var ageSuffixLabel: UILabel?

    // Category
    @IBOutlet weak var categoryTitleLabel: UILabel?
    @IBOutlet weak var categoryImageView: UIImageView?
    @IBOutlet weak var categoryLabel: UILabel?

    // Developer
    @IBOutlet weak var developerTitleLabel: UILabel?
    @IBOutlet weak var developerNameLabel: UILabel?

    // Language
    @IBOutlet weak var languageTitleLabel: UILabel?
    @IBOutlet weak var languageSymbolLabel: UILabel?
    @IBOutlet weak var languageLocalizedSymbolLabel: UILabel?

    override func bind(model: AppDetailTableViewCellModel) {
        setupRating(with: model.app)
        setupAge(with: model.app)
        setupCategory(with: model.app)
        setupDeveloper(with: model.app)
        setupLanguage(with: model.app)
    }

}

// MARK: - Private

private extension AppDetailSummaryTableViewCell {

    private func setupRating(with model: App) {
        ratingContainerView?.isHidden = (model.hasRating == false)
        ratingTitleLabel?.text = model.userRatingCount.map { String(format: Text.number_of_review.value, $0.humanReadableText) }
        ratingLabel?.text = model.averageUserRating.map { String(format: "%.1f", $0) }
        model.averageUserRating.map { ratingView?.setRating($0) }
    }

    private func setupAge(with model: App) {
        ageTitleLabel?.text = Text.age.value
        ageLabel?.text = model.contentAdvisoryRating
        ageSuffixLabel?.text = Text.age_suffix.value
    }

    private func setupCategory(with model: App) {
        categoryTitleLabel?.text = Text.category.value
        categoryLabel?.text = model.genres?.first
    }

    private func setupDeveloper(with model: App) {
        developerTitleLabel?.text = Text.developer.value
        developerNameLabel?.text = model.artistName
    }

    private func setupLanguage(with model: App) {
        languageTitleLabel?.text = Text.language.value
        languageSymbolLabel?.text = model.languageCodesISO2A?.first
        languageLocalizedSymbolLabel?.text = model.languageCodesISO2A?.first
    }

}
