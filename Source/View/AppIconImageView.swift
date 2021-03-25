//
//  AppIconImageView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


private enum Design {

    static let cornerRadiusRatio: CGFloat = 0.2
    static let borderWidth: CGFloat = 0.5
    static let borderColor: UIColor = .lightGray
    static let placeholderColor: UIColor = .lightGray

}

class AppIconView: UIView {

    // MARK: - Variables

    private let imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }

    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.width * Design.cornerRadiusRatio
        layer.borderWidth = Design.borderWidth
        layer.borderColor = Design.borderColor.cgColor
        layer.masksToBounds = true
    }

    func set(model: App) {
        load(url: model.iconImageURL)
    }

    func load(url: URL?) {
        imageView.load(url: url, placeholderColor: Design.placeholderColor)
    }

    func reset() {
        imageView.image = nil
        imageView.backgroundColor = Design.placeholderColor
    }

    private func setupSubViews() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

}
