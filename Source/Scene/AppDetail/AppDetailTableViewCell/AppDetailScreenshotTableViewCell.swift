//
//  AppDetailScreenshotTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


class AppDetailScreenshotTableViewCell: BaseAppDetailTableViewCell {

    override class var cellHeight: CGFloat { UIScreen.main.bounds.height * 0.55 }

    static let style: ScreenshotGalleryViewStyle = ScreenshotGalleryViewStylePreset.appDetail.value

    private lazy var galleryView: ScreenshotGalleryView = {
        let view = ScreenshotGalleryView(style: Self.style)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        return view
    }()

    private var screenshotURLStrings: [String] = []

    override func bind(model: AppDetailTableViewCellModel) {
        screenshotURLStrings = model.app.screenshotUrls ?? []
        galleryView.reloadData()
    }

    override func setupSubViews() {
        super.setupSubViews()
        contentView.addSubview(galleryView)
        NSLayoutConstraint.activate([
            galleryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            galleryView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            galleryView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

}

extension AppDetailScreenshotTableViewCell: ScreenshotGalleryViewDataSource {

    func screenshotGalleryViewNumberOfImages(view: ScreenshotGalleryView) -> Int {
        return screenshotURLStrings.count
    }

    func screenshotGalleryView(view: ScreenshotGalleryView, imageURLStringForItemAt index: Int) -> String? {
        return screenshotURLStrings[safe: index]
    }

}
