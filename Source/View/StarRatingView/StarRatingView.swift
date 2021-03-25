//
//  StarRatingView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


class StarRatingView: UIView {

    // MARK: - Variables

    private static let maximumRating: Int = 5

    private let componentViews: [StarRatingComponentView] = {
        (0..<maximumRating).map { _ in
            let view = StarRatingComponentView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        return stackView
    }()

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

    func setRating(_ rating: Float) {
        let fullColoredStarCount: Int = Int(floor(rating))
        let noColoredRatingCount: Int = Self.maximumRating - Int(ceil(rating))
        let decimalRating: Float = rating - Float(fullColoredStarCount)
        let decimalRatingIndex: Int? = decimalRating > 0 ? fullColoredStarCount : nil

        // Full Star
        (0..<fullColoredStarCount).forEach {
            componentViews[safe: $0]?.setRating(1)
        }

        // Partial Star
        decimalRatingIndex.map {
            componentViews[safe: $0]?.setRating(decimalRating)
        }

        // Empty Star
        (Self.maximumRating - noColoredRatingCount..<Self.maximumRating).forEach {
            componentViews[safe: $0]?.setRating(0)
        }
    }
    
    private func setupSubViews() {
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        componentViews.forEach {
            stackView.addArrangedSubview($0)
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalTo: $0.heightAnchor)
            ])
        }
    }

}
