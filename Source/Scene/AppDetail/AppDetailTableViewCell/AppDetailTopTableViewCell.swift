//
//  AppDetailTopTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


protocol AppDetailTopTableViewCellDelegate: AnyObject {

    func appDetailTopTableViewCell(_ cell: AppDetailTopTableViewCell, didChangeContentHidden isHidden: Bool)

}

class AppDetailTopTableViewCell: BaseAppDetailTableViewCell {

    @IBOutlet weak var iconView: AppIconView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var purchaseButton: AppPurchaseButton?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var iconViewBottomConstraint: NSLayoutConstraint?

    private var isAllComponentHidden: Bool = false

    override func bind(model: AppDetailTableViewCellModel) {
        iconView?.set(model: model.app)
        titleLabel?.text = model.app.trackName
        descriptionLabel?.text = model.app.genres?.first
        purchaseButton?.set(model: model.app)
    }

    override func contentOffsetDidChange(_ offset: CGPoint) {
        let isShareButtonFullVisible: Bool = shareButton.map { VisibilityChecker.check($0, threshold: .full) } == true
        setAllComponentHidden(isShareButtonFullVisible == false)
    }

}

// MARK: - Private

private extension AppDetailTopTableViewCell {

    private func setAllComponentHidden(_ isHidden: Bool, animated: Bool = true) {
        guard isAllComponentHidden != isHidden else {
            return
        }
        isAllComponentHidden = isHidden

        let animationBlock: (UIView) -> Void = {
            $0.alpha = isHidden ? 0 : 1
        }
        let completionBlock: (UIView) -> Void = {
            $0.isHidden = isHidden
        }
        [iconView, titleLabel, descriptionLabel, purchaseButton, shareButton].compactMap { $0 }.forEach { (view) in
            if isHidden == false {
                view.isHidden = false
            }
            if animated {
                UIView.animate(withDuration: 0.3, animations: {
                    animationBlock(view)
                }, completion: { _ in
                    completionBlock(view)
                })
            } else {
                animationBlock(view)
                completionBlock(view)
            }
        }

        delegate?.appDetailTopTableViewCell(self, didChangeContentHidden: isHidden)
    }

}
