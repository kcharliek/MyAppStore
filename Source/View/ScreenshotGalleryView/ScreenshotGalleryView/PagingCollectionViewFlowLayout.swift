//
//  PagingCollectionViewFlowLayout.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


class PagingCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Variables

    var pageWidth: CGFloat = 0.0
    var offsetDelta: CGFloat = 0.0

    private let flickVelocityThreshold: CGFloat = 0.5

    var currentPage: Int {
        Int(round(offsetXRatio))
    }

    var numberOfPages: Int {
        guard let collectionView = self.collectionView,
              collectionView.contentSize.width < .greatestFiniteMagnitude,
              pageWidth > 0.0
        else {
            return 0
        }

        return Int(ceil((collectionView.contentSize.width - sectionInset.left - sectionInset.right) / pageWidth))
    }

    private var offsetXRatio: CGFloat {
        guard let collectionView = self.collectionView,
              pageWidth > 0.0
        else {
            return 0.0
        }
        return (collectionView.contentOffset.x + offsetDelta) / pageWidth
    }

    // MARK: - Methods

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard abs(velocity.x) > flickVelocityThreshold else {
            // If velocity is low, return to currentPage
            return CGPoint(x: contentOffsetX(of: currentPage), y: proposedContentOffset.y)
        }

        let nextPage: Int = Int(ceil(offsetXRatio))
        let previousPage: Int = Int(floor(offsetXRatio))
        let targetPage = velocity.x > 0.0 ? nextPage : previousPage
        return CGPoint(x: contentOffsetX(of: targetPage), y: proposedContentOffset.y)
    }

    func contentOffsetX(of page: Int) -> CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }

        let baseOffsetX = (CGFloat(page) * pageWidth) - offsetDelta

        if numberOfPages == 1 {
            return -collectionView.contentInset.left
        } else {
            return min(
                baseOffsetX - collectionView.contentInset.left,
                (collectionView.contentSize.width + collectionView.contentInset.right) - collectionView.frame.width
            )
        }
    }

}

