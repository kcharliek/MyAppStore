//
//  ScreenshotGalleryView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


protocol ScreenshotGalleryViewDataSource: AnyObject {

    func screenshotGalleryViewNumberOfImages(view: ScreenshotGalleryView) -> Int
    func screenshotGalleryView(view: ScreenshotGalleryView, imageURLStringForItemAt index: Int) -> String?

}

class ScreenshotGalleryView: UIView {

    // MARK: - Variables
    
    weak var dataSource: ScreenshotGalleryViewDataSource?

    private let style: ScreenshotGalleryViewStyle

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: style.sideInset, bottom: style.bottomInset, right: style.sideInset)

        collectionView.register(ScreenshotGalleryCollectionViewCell.self)

        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = PagingCollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = style.lineSpacing
        layout.minimumInteritemSpacing = 0.0
        layout.pageWidth = style.pageWidth

        return layout
    }()

    // MARK: - Initializer
    
    init(style: ScreenshotGalleryViewStyle) {
        self.style = style
        super.init(frame: .zero)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        self.style = ScreenshotGalleryViewStylePreset.default.value
        super.init(coder: coder)
        setupSubViews()
    }

    // MARK: - Methods

    func reloadData() {
        collectionView.reloadData()
    }

    private func setupSubViews() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

}

extension ScreenshotGalleryView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfImages = dataSource?.screenshotGalleryViewNumberOfImages(view: self) ?? 0
        return min(numberOfImages, style.maximumCount)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ScreenshotGalleryCollectionViewCell.self, for: indexPath)

        let imageURLString = dataSource?.screenshotGalleryView(view: self, imageURLStringForItemAt: indexPath.item)
        cell.loadImage(imageURLString)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return style.itemSize
    }

}
