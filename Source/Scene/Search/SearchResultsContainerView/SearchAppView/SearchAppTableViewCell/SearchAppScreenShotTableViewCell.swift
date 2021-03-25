//
//  SearchAppScreenShotTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


struct SearchAppScreenShotTableViewCellModel {

    var app: App

}


class SearchAppScreenShotTableViewCell: UITableViewCell {

    // MARK: - Variables

    static var cellHeight: CGFloat {
        return style.viewHeight
    }

    private static let style: ScreenshotGalleryViewStyle = ScreenshotGalleryViewStylePreset.appList.value

    private var screenshotURLStrings: [String] = []

    private lazy var galleryView: ScreenshotGalleryView = {
        let view = ScreenshotGalleryView(style: Self.style)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self

        return view
    }()

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

        // TODO: Reset Gallery View
    }

    func bind(model: SearchAppScreenShotTableViewCellModel) {
        screenshotURLStrings = model.app.screenshotUrls ?? []
        galleryView.reloadData()
    }

}

// MAKR: - ScreenshotGalleryViewDataSource

extension SearchAppScreenShotTableViewCell: ScreenshotGalleryViewDataSource {

    func screenshotGalleryViewNumberOfImages(view: ScreenshotGalleryView) -> Int {
        return screenshotURLStrings.count
    }

    func screenshotGalleryView(view: ScreenshotGalleryView, imageURLStringForItemAt index: Int) -> String? {
        return screenshotURLStrings[safe: index]
    }

}

// MARK: - Private

private extension SearchAppScreenShotTableViewCell {

    func setupSubViews() {
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false

        contentView.addSubview(galleryView)
        NSLayoutConstraint.activate([
            galleryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            galleryView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            galleryView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

}
