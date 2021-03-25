//
//  SearchHistoryView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit


protocol SearchHistoryViewDelegate: AnyObject {

    func searchHistoryView(_ view: SearchHistoryView, didSelectRecentQuery query: String)

}

private enum Design {

    static let tableViewContentInset: UIEdgeInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
    static let cellHeight: CGFloat = 44
    static let sectionHeaderFont: UIFont = .systemFont(ofSize: 21, weight: .semibold)
    static let sectionHeaderTextColor: UIColor = Color.defaultTextColor.value

}

class SearchHistoryView: UIView {

    // MARK: - Variables

    weak var delegate: SearchHistoryViewDelegate?

    private let viewModel: SearchHistoryViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Color.defaultViewBackground.value
        tableView.contentInset = Design.tableViewContentInset

        tableView.register(SearchHistoryTableViewCell.self)

        return tableView
    }()

    // MARK: - Initializer

    init(viewModel: SearchHistoryViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        bind(viewModel)
        setupSubViews()
    }

    private func bind(_ viewModel: SearchHistoryViewModel) {
        viewModel.onSearchHistoryUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Do Not Use With Interface Builder")
    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension SearchHistoryView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentQueries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SearchHistoryTableViewCell.self, for: indexPath)

        cell.setText(viewModel.recentQueries[safe: indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Design.cellHeight
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Text.recent_searches.value
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Design.cellHeight
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else {
            return
        }

        headerView.textLabel?.font = Design.sectionHeaderFont
        headerView.textLabel?.textColor = Design.sectionHeaderTextColor
        headerView.backgroundView?.backgroundColor = Color.defaultViewBackground.value
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let selectedQuery = viewModel.recentQueries[safe: indexPath.row] else {
            return
        }
        delegate?.searchHistoryView(self, didSelectRecentQuery: selectedQuery)
    }

}

// MARK: - Private

private extension SearchHistoryView {
    
    private func setupSubViews() {
        backgroundColor = Color.defaultViewBackground.value

        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

}
