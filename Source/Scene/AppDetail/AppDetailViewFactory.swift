//
//  AppDetailViewFactory.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import Foundation


protocol AppDetailViewFactory {
    
    func makeAppDetailViewModel() -> AppDetailViewModel
    func makeAppDetailViewController() -> AppDetailViewController

}

class DefaultAppDetailViewFactory: AppDetailViewFactory {
    
    private let app: App

    init(app: App) {
        self.app = app
    }

    func makeAppDetailViewController() -> AppDetailViewController {
        return AppDetailViewController.make(viewModel: makeAppDetailViewModel())
    }

    func makeAppDetailViewModel() -> AppDetailViewModel {
        return AppDetailViewModel(app: app)
    }

}
