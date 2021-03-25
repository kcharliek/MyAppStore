//
//  ScreenshotGalleryCollectionViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


class ScreenshotGalleryCollectionViewCell: UICollectionViewCell {

    // MARK: - Variables

    private let imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func loadImage(_ urlString: String?) {
        let url = urlString.flatMap { URL(string: $0) }
        imageView.load(url: url, placeholderColor: .lightGray)
    }

    private func setupSubViews() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

}
