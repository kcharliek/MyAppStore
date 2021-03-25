//
//  SearchQuerySuggestionView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit


protocol SearchQuerySuggestionViewDelegate: AnyObject {

    func searchQuerySuggestionView(_ view: SearchQuerySuggestionView, didSelectQuery query: String)

}

class SearchQuerySuggestionView: UIView {

    // MARK: - Variables

    weak var delegate: SearchQuerySuggestionViewDelegate?

    private let viewModel: SearchQuerySuggestionViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerNib(SearchQuerySuggestionTableViewCell.self)

        return tableView
    }()

    // MARK: - Initializer

    init(viewModel: SearchQuerySuggestionViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        setupSubviews()
        bind(viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("Do Not Use With Interface Builder")
    }

    // MARK: - Methods

    private func bind(_ viewModel: SearchQuerySuggestionViewModel) {
        viewModel.onQuerySuggested = { [weak self] (result) in
            result.onSuccess {
                self?.updateSuggestions($0)
            }
        }
    }

}

extension SearchQuerySuggestionView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.suggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SearchQuerySuggestionTableViewCell.self, for: indexPath)

        let suggestion: String = viewModel.suggestions[safe: indexPath.row] ?? ""
        cell.set(text: suggestion)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let suggestion: String = viewModel.suggestions[safe: indexPath.row] else {
            return
        }
        delegate?.searchQuerySuggestionView(self, didSelectQuery: suggestion)
    }

}

private extension SearchQuerySuggestionView {

    func setupSubviews() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        backgroundColor = Color.defaultViewBackground.value
    }

    func updateSuggestions(_ suggestions: [String]) {
        guard suggestions.isEmpty == false else {
            tableView.isHidden = true
            return
        }
        tableView.isHidden = false
        tableView.reloadData()
    }

}
