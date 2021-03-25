//
//  SearchEmptyView.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/25.
//

import UIKit


class SearchAppEmptyView: UIView {

    // MARK: - Variables

    private let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.text = Text.no_data.value
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = Color.defaultTextColor.value
        label.textAlignment = .center

        return label
    }()

    private let queryLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center

        return label
    }()

    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }

    // MARK: - Methods

    func setQuery(_ query: String?) {
        if let query = query {
            queryLabel.text = "\'\(query)\'"
        } else {
            queryLabel.text = ""
        }
    }

    func setupSubViews() {
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        [titleLabel, queryLabel].forEach(stackView.addArrangedSubview(_:))
    }

}
