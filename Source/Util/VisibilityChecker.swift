//
//  UIViewExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


class VisibilityChecker {

    enum Threshold {
        case least
        case half
        case full
        case custom(rate: CGFloat)

        var rate: CGFloat {
            switch self {
            case .least: return .leastNormalMagnitude
            case .half: return 0.5
            case .full: return 1.0
            case .custom(let rate): return rate
            }
        }
    }

    static func check(_ view: UIView, in inView: UIView? = nil, threshold: Threshold = .least) -> Bool {
        return isVisible(view: view, in: inView ?? view.superview, threshold: threshold)
    }

    private static func isVisible(view: UIView, in inView: UIView?, threshold: Threshold) -> Bool {
        guard let inView = inView else {
            return true
        }
        let viewFrame = inView.convert(view.bounds, from: view)

        if viewFrame.intersects(inView.bounds) {
            let intersectionArea = viewFrame.intersection(inView.bounds).area
            let thresholdArea = view.bounds.area * threshold.rate

            if intersectionArea >= (thresholdArea - 0.000001) {
                return isVisible(view: view, in: inView.superview, threshold: threshold)
            }
        }

        return false
    }

}

private extension CGRect {

    var area: CGFloat {
        size.width * size.height
    }

}
