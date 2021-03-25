//
//  AppDetailDescriptionTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


private enum Design {

    static let margin: CGFloat = 20
    static let font: UIFont = .systemFont(ofSize: 15, weight: .light)
    static let numberOfLines: Int = 4

}

class AppDetailDescriptionTableViewCell: BaseAppDetailTableViewCell {

    private let descriptionLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = Design.numberOfLines
        label.font = Design.font

        return label
    }()

    override func bind(model: AppDetailTableViewCellModel) {
        descriptionLabel.text = model.app.description
    }

    override func setupSubViews() {
        super.setupSubViews()

        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.margin),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Design.margin),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Design.margin),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Design.margin),
        ])
    }

}

