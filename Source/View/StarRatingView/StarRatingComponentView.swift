//
//  StarRatingComponentView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


private enum Design {

    static let starRatingColor: UIColor = Color.starRatingColor.value

}

class StarRatingComponentView: UIView {

    // MARK: - Variables

    private let maskingView: UIView = {
        let view = UIView()

        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let colorView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Design.starRatingColor

        return view
    }()

    private let starOutlineImageView: UIImageView = {
        let imageView = UIImageView(image: Image.star_rating_outline.value)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Design.starRatingColor

        return imageView
    }()

    private var widthConstraint: NSLayoutConstraint?

    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }

    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()

        let maskingLayer = CALayer()
        maskingLayer.frame = self.bounds
        maskingLayer.contents = Image.star_rating_mask.value.cgImage
        maskingView.layer.mask = maskingLayer
    }

    func setRating(_ rating: Float) {
        widthConstraint = widthConstraint?.multiplied(CGFloat(rating))
    }

    private func setupSubViews() {
        addSubview(maskingView)
        NSLayoutConstraint.activate([
            maskingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            maskingView.topAnchor.constraint(equalTo: self.topAnchor),
            maskingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            maskingView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        maskingView.addSubview(colorView)
        widthConstraint = colorView.widthAnchor.constraint(equalTo: maskingView.widthAnchor, multiplier: 1)
        widthConstraint?.isActive = true
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: maskingView.leadingAnchor),
            colorView.topAnchor.constraint(equalTo: maskingView.topAnchor),
            colorView.bottomAnchor.constraint(equalTo: maskingView.bottomAnchor)
        ])

        addSubview(starOutlineImageView)
        NSLayoutConstraint.activate([
            starOutlineImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starOutlineImageView.topAnchor.constraint(equalTo: topAnchor),
            starOutlineImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            starOutlineImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}

private extension NSLayoutConstraint {

    func multiplied(_ multiplier: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = self.firstItem else {
            assertionFailure("FirstItem Nil")
            return self
        }

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        newConstraint.isActive = true
        return newConstraint
    }

}

