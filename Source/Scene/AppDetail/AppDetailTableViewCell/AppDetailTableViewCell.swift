//
//  AppDetailTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


struct AppDetailTableViewCellModel {

    let app: App
    let component: AppDetailComponent

    init(app: App, component: AppDetailComponent) {
        self.app = app
        self.component = component
    }

}

class BaseAppDetailTableViewCell: UITableViewCell {

    typealias AppDetailTableViewCellDelegate = AppDetailTopTableViewCellDelegate

    // MARK: - Variables

    class var cellHeight: CGFloat { UITableView.automaticDimension }

    weak var delegate: AppDetailTableViewCellDelegate?

    private weak var contentOffsetNotifier: ScrollViewContentOffsetNotifier?

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }

    // MARK: - Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        contentOffsetNotifier?.unregister(withIdentifier: className)
    }

    func observeOffset(with notifier: ScrollViewContentOffsetNotifier) {
        contentOffsetNotifier = notifier
        notifier.register(observer: .init(identifier: className, action: { [weak self] (offset) in
            self?.contentOffsetDidChange(offset)
        }))
    }

    func bind(model: AppDetailTableViewCellModel) {}

    func contentOffsetDidChange(_ offset: CGPoint) {}

    func setupSubViews() {
        selectionStyle = .none
    }

}
