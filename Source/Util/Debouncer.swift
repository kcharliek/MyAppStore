//
//  Debouncer.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import Foundation


class Debouncer {

    // MARK: - Variables

    private let delay: TimeInterval
    private let queue: DispatchQueue
    private var currentWorkItem: DispatchWorkItem

    // MARK: - Initializer

    init(delay: TimeInterval, queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue

        currentWorkItem = DispatchWorkItem(block: {})
    }

    // MARK: - Methods

    func schedule(block: @escaping () -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }

            self.currentWorkItem.cancel()

            let newItem = DispatchWorkItem(block: block)
            self.queue.asyncAfter(deadline: .now() + self.delay, execute: newItem)
            self.currentWorkItem = newItem
        }
    }

}
