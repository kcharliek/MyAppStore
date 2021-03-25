//
//  AppDetailViewModel.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import Foundation


class AppDetailViewModel {

    // MARK: - Variables

    let app: App

    var sections: [AppDetailSection] {
        AppDetailSection.allCases.filter { $0.isValid(for: app) }
    }

    // MARK: - Initializer

    init(app: App) {
        self.app = app
    }

    // MARK: - Methods

    func numberOfComponents(in section: Int) -> Int {
        let section = sections[safe: section]
        return (section?.components(for: app).count).orZero
    }

    func component(at indexPath: IndexPath) -> AppDetailComponent? {
        let section = sections[safe: indexPath.section]
        let components = section?.components(for: app)
        return components?[safe: indexPath.row]
    }

    func cellModel(at indexPath: IndexPath) -> AppDetailTableViewCellModel? {
        guard let component = component(at: indexPath) else {
            return nil
        }
        return .init(app: app, component: component)
    }

    func sectionTitle(in section: Int) -> String? {
        return sections[safe: section]?.title
    }

}

enum AppDetailComponent {

    case top
    case summary
    case screenshot
    case description
    case developer
    case provider
    case fileSize
    case category
    case language
    case developerWebsite

    var cellType: BaseAppDetailTableViewCell.Type {
        switch self {
        case .top:
            return AppDetailTopTableViewCell.self
        case .summary:
            return AppDetailSummaryTableViewCell.self
        case .screenshot:
            return AppDetailScreenshotTableViewCell.self
        case .description:
            return AppDetailDescriptionTableViewCell.self
        case .developer:
            return AppDetailDeveloperTableViewCell.self
        case .provider:
            return AppDetailProviderTableViewCell.self
        case .fileSize:
            return AppDetailFileSizeTableViewCell.self
        case .category:
            return AppDetailCategoryTableViewCell.self
        case .language:
            return AppDetailLanguageTableViewCell.self
        case .developerWebsite:
            return AppDetailDeveloperWebsiteTableViewCell.self
        }
    }

    func isValid(for model: App) -> Bool {
        switch self {
        case .top, .summary, .developer:
            return true
        case .screenshot:
            return model.screenshotUrls.isNotEmpty
        case .description:
            return model.description.isNotEmpty
        case .provider:
            return model.sellerName.isNotEmpty
        case .fileSize:
            return model.fileSizeBytes.isNotEmpty
        case .category:
            return (model.genres?.first).isNotEmpty
        case .language:
            return model.languageCodesISO2A.isNotEmpty
        case .developerWebsite:
            return model.sellerUrl.isNotEmpty
        }
    }

}

enum AppDetailSection: CaseIterable {

    case top
    case screenshot
    case description
    case info

    var title: String? {
        switch self {
        case .top:
            return nil
        case .screenshot:
            return Text.screenshots.value
        case .description:
            return nil
        case .info:
            return Text.information.value
        }
    }

    private var allComponents: [AppDetailComponent] {
        switch self {
        case .top:
            return [.top, .summary]
        case .screenshot:
            return [.screenshot]
        case .description:
            return [.description, .developer]
        case .info:
            return [.provider, .fileSize, .category, .language, .developerWebsite]
        }
    }

    func isValid(for model: App) -> Bool {
        return components(for: model).isEmpty == false
    }

    func components(for model: App) -> [AppDetailComponent] {
        allComponents.filter { $0.isValid(for: model) }
    }

}
