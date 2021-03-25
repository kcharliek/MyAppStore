//
//  ScrollViewContentOffsetNotifier.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


class ScrollViewContentOffsetNotifier {

    typealias Action = (CGPoint) -> Void

    struct Observer {
        var identifier: String
        var action: Action
    }

    // MARK: - Variables

    private weak var scrollView: UIScrollView?
    private var observers: [Observer] = []
    private var contentOffsetObserver: NSKeyValueObservation?

    // MARK: - Initializer

    init(scrollView: UIScrollView) {
        self.scrollView = scrollView

        contentOffsetObserver = scrollView.observe(\UIScrollView.contentOffset, options: .new) { [weak self] table, change in
            guard let newContentOffset = change.newValue else {
                return
            }
            self?.update(newContentOffset)
        }
    }

    deinit {
        contentOffsetObserver = nil
    }

    // MARK: - Methods

    func register(observer: Observer) {
        if observers.contains(where: { $0.identifier == observer.identifier }) == false {
            observers.append(observer)
        }
    }

    func unregister(withIdentifier identifier: String) {
        observers.removeAll(where: { $0.identifier == identifier })
    }

    func update(_ offset: CGPoint) {
        observers.forEach  {
            $0.action(offset)
        }
    }

}
