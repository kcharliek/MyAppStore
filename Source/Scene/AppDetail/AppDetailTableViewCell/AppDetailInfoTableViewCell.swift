//
//  AppDetailInfoTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


private enum Design {

    static let horizontalMargin: CGFloat = 20
    static let verticalMargin: CGFloat = 10
    static let titleFont: UIFont = .systemFont(ofSize: 15, weight: .light)
    static let titleTextColor: UIColor = .lightGray
    static let detailFont: UIFont = .systemFont(ofSize: 15, weight: .light)
    static let detailTextColor: UIColor = Color.defaultTextColor.value

}

class AppDetailInfoTableViewCell: BaseAppDetailTableViewCell {

    // MARK: - Variables

    let titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Design.titleFont
        label.textColor = Design.titleTextColor

        return label
    }()

    let detailLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Design.detailFont
        label.textColor = Design.detailTextColor

        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal

        return stackView
    }()

    // MARK: - Methods

    override func setupSubViews() {
        super.setupSubViews()

        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.verticalMargin),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Design.verticalMargin),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Design.horizontalMargin),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Design.horizontalMargin)
        ])

        [titleLabel, detailLabel].forEach(stackView.addArrangedSubview(_:))
    }

}


class AppDetailProviderTableViewCell: AppDetailInfoTableViewCell {

    override func bind(model: AppDetailTableViewCellModel) {
        titleLabel.text = Text.provider.value
        detailLabel.text = model.app.sellerName
    }

}

class AppDetailFileSizeTableViewCell: AppDetailInfoTableViewCell {

    override func bind(model: AppDetailTableViewCellModel) {
        titleLabel.text = Text.file_size.value
        detailLabel.text = model.app.fileSizeBytes.map { $0 + " Bytes" }
    }

}

class AppDetailCategoryTableViewCell: AppDetailInfoTableViewCell {

    override func bind(model: AppDetailTableViewCellModel) {
        titleLabel.text = Text.category.value
        detailLabel.text = model.app.genres?.first
    }

}

class AppDetailLanguageTableViewCell: AppDetailInfoTableViewCell {

    override func bind(model: AppDetailTableViewCellModel) {
        titleLabel.text = Text.language.value
        detailLabel.text = (model.app.languageCodesISO2A?.count).map { String(format: Text.number_of_language.value, $0) }
    }

}
