//
//  SearchAppView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit


protocol SearchAppViewDelegate: AnyObject {

    func searchAppView(_ view: SearchAppView, didSelectApp app: App)

}

class SearchAppView: UIView {

    // MARK: - Variables
    
    weak var delegate: SearchAppViewDelegate?
    
    private let viewModel: SearchAppViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.registerNib(AppTableViewCell.self)
        tableView.register(SearchAppScreenShotTableViewCell.self)
        tableView.separatorStyle = .none

        return tableView
    }()

    private let emptyAppView: SearchAppEmptyView = {
        let view = SearchAppEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializer

    init(viewModel: SearchAppViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        setupSubViews()
        bind(viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("Do Not Use With Interface Builder")
    }

    private func bind(_ viewModel: SearchAppViewModel) {
        viewModel.onWillStartAppSearching = { [weak self] in
            self?.setAllComponentHidden(true)
        }
        viewModel.onAppSearched = { [weak self] (_) in
            DispatchQueue.main.async {
                self?.setAllComponentHidden(false)
                self?.reloadData()
            }
        }
    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension SearchAppView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.apps.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let app = viewModel.apps[safe: section] else {
            return 0
        }
        if app.screenshotUrls.isNotEmpty {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: // App Description
            let cell = tableView.dequeueReusableCell(AppTableViewCell.self, for: indexPath)
            let cellModel = viewModel.appCellModel(at: indexPath)
            cellModel.map(cell.bind(model:))
            return cell
        case 1: // App Screenshot
            let cell = tableView.dequeueReusableCell(SearchAppScreenShotTableViewCell.self, for: indexPath)
            let cellModel = viewModel.screenshotCellModel(at: indexPath)
            cellModel.map(cell.bind(model:))
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: // App Description
            return UITableView.automaticDimension
        case 1: // App Screenshot
            return SearchAppScreenShotTableViewCell.cellHeight
        default:
            return 0.0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedApp = viewModel.apps[safe: indexPath.section] else {
            return
        }
        delegate?.searchAppView(self, didSelectApp: selectedApp)
    }

}

// MARK: - Private

private extension SearchAppView {

    func setupSubViews() {
        backgroundColor = Color.defaultViewBackground.value

        [emptyAppView, tableView].forEach {
            self.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.topAnchor),
                $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                $0.leftAnchor.constraint(equalTo: self.leftAnchor),
                $0.rightAnchor.constraint(equalTo: self.rightAnchor)
            ])
        }
    }

    func reloadData() {
        tableView.isHidden = viewModel.apps.isEmpty

        if viewModel.apps.isEmpty {
            self.emptyAppView.setQuery(self.viewModel.query)
        } else {
            self.tableView.reloadData()
        }
    }

    func setAllComponentHidden(_ isHidden: Bool) {
        emptyAppView.isHidden = isHidden
        tableView.isHidden = isHidden
    }

}
