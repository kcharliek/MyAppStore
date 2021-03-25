//
//  ScreenshotGalleryViewStyle.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


struct ScreenshotGalleryViewStyle {

    let itemWidth: CGFloat
    let sideInset: CGFloat
    let lineSpacing: CGFloat
    let bottomInset: CGFloat
    let maximumCount: Int

    var viewHeight: CGFloat {
        return itemSize.height + bottomInset
    }

    var itemSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        let itemRatio = screenSize.height / screenSize.width
        return .init(width: itemWidth, height: itemWidth * itemRatio)
    }

    var offsetDelta: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        return (screenWidth - itemWidth) / 2.0 - sideInset
    }

    var pageWidth: CGFloat {
        return itemWidth + lineSpacing
    }

}

enum ScreenshotGalleryViewStylePreset {

    case `default`
    case appList
    case appDetail
    case appDetailLarge

    var value: ScreenshotGalleryViewStyle {
        let screenWidth = UIScreen.main.bounds.size.width

        switch self {
        case .default, .appList:
            let sideInset: CGFloat = 20
            let lineSpacing: CGFloat = 8
            return .init(
                itemWidth: (screenWidth - (sideInset * 2) - (lineSpacing * 2)) / 3,
                sideInset: sideInset,
                lineSpacing: lineSpacing,
                bottomInset: 15,
                maximumCount: 3
            )
        case .appDetail:
            return .init(
                itemWidth: screenWidth * 0.5,
                sideInset: 20,
                lineSpacing: 8,
                bottomInset: 0,
                maximumCount: .max
            )

        case .appDetailLarge:
            return .init(
                itemWidth: screenWidth * 0.8,
                sideInset: 20,
                lineSpacing: 8,
                bottomInset: 15,
                maximumCount: .max
            )
        }
    }

}
