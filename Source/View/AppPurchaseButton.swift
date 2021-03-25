//
//  AppPurchaseButton.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


private enum Design {

    static let size: CGSize  = .init(width: 72, height: 30)
    static let font: UIFont = .systemFont(ofSize: 15, weight: .semibold)
    static let contentInset: UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)

}

enum AppPurchaseButtonStyle {

    case appList
    case appDetail

    var backgroundColor: UIColor {
        switch self {
        case .appList:
            return UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        case .appDetail:
            return .systemBlue
        }
    }

    var textColor: UIColor {
        switch self {
        case .appList:
            return .systemBlue
        case .appDetail:
            return .white
        }
    }

}

class AppPurchaseButton: UIButton {

    var style: AppPurchaseButtonStyle = .appList

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

        layer.cornerRadius = bounds.size.height / 2
        layer.masksToBounds = true
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return Design.size
    }

    override var intrinsicContentSize: CGSize {
        return Design.size
    }

    func set(model: App) {
        let purchaseButtonTitle = model.price.orZero > 0 ? model.formattedPrice : Text.purchase.value
        setTitle(purchaseButtonTitle, for: .normal)
    }

    private func setupSubViews() {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = Design.font
        contentEdgeInsets = Design.contentInset
        backgroundColor = style.backgroundColor
        titleLabel?.textColor = style.textColor
        setTitle(Text.purchase.value, for: .normal)
    }

}
