//
//  AppDetailViewController.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import UIKit


private enum Design {

    static let iconViewHeight: CGFloat = 25
    static let sectionHeaderHeight: CGFloat = 25
    static let sectionHeaderFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
    static let sectionHeaderTextColor: UIColor = Color.defaultTextColor.value

}

class AppDetailViewController: UIViewController {

    static func make(viewModel: AppDetailViewModel) -> AppDetailViewController {
        let vc = UIStoryboard.instantiateViewController(Self.self)
        vc.viewModel = viewModel
        return vc
    }

    // MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables

    weak var coordinator: AppDetailCoordinator?

    @Unspecified private var viewModel: AppDetailViewModel
    private var isNavigationContentHidden: Bool = false

    private lazy var contentOffsetNotifier: ScrollViewContentOffsetNotifier = {
        ScrollViewContentOffsetNotifier(scrollView: tableView)
    }()

    private let navigationIconView: AppIconView = {
        let iconView = AppIconView()

        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: Design.iconViewHeight),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor)
        ])

        return iconView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViews()
        setNavigationContentHidden(true, animated: false)
        tableView?.reloadData()
    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension AppDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfComponents(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel.cellModel(at: indexPath) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(cellModel.component.cellType, for: indexPath)
        cell.bind(model: cellModel)
        cell.observeOffset(with: contentOffsetNotifier)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let component = viewModel.component(at: indexPath) else {
            return 0.0
        }
        return component.cellType.cellHeight
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(in: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sectionTitle(in: section) != nil ? Design.sectionHeaderHeight : .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else {
            return
        }

        headerView.textLabel?.font = Design.sectionHeaderFont
        headerView.textLabel?.textColor = Design.sectionHeaderTextColor
        headerView.backgroundView?.backgroundColor = Color.defaultViewBackground.value
    }

}

// MARK: - AppDetailTopTableViewCellDelegate

extension AppDetailViewController: AppDetailTopTableViewCellDelegate {

    func appDetailTopTableViewCell(_ cell: AppDetailTopTableViewCell, didChangeContentHidden isHidden: Bool) {
        setNavigationContentHidden(isHidden == false)
    }

}

// MARK: - Private

private extension AppDetailViewController {

    private func setupSubViews() {
        view.backgroundColor = Color.defaultViewBackground.value
        setupNavigationController()
        setupTableView()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear

        navigationItem.titleView = navigationIconView
        navigationIconView.set(model: viewModel.app)
    }

    private func setupTableView() {
        tableView?.register(AppDetailScreenshotTableViewCell.self)
        tableView?.register(AppDetailDescriptionTableViewCell.self)
        tableView?.register(AppDetailProviderTableViewCell.self)
        tableView?.register(AppDetailFileSizeTableViewCell.self)
        tableView?.register(AppDetailLanguageTableViewCell.self)
        tableView?.register(AppDetailDeveloperWebsiteTableViewCell.self)
        tableView?.register(AppDetailCategoryTableViewCell.self)
    }

    private func setNavigationContentHidden(_ isHidden: Bool, animated: Bool = true) {
        guard isNavigationContentHidden != isHidden else {
            return
        }
        isNavigationContentHidden = isHidden

        let animationBlock: (UIView) -> Void = { view in
            view.alpha = isHidden ? 0 : 1
        }

        let completionBlock: (UIView) -> Void = { view in
            view.isHidden = isHidden
        }
        let rightNavigationItemViews: [UIView] = navigationItem.rightBarButtonItems?.compactMap { $0.customView } ?? []
        let navigationItemViews: [UIView] = rightNavigationItemViews + [navigationItem.titleView].compactMap { $0 }

        navigationItemViews.forEach { (view) in
            if isHidden == false {
                view.isHidden = false
            }
            if animated {
                UIView.animate(withDuration: 0.3, animations: {
                    animationBlock(view)
                    }, completion: { _ in
                        completionBlock(view)
                    })
            } else {
                animationBlock(view)
                completionBlock(view)
            }
        }
    }

}
