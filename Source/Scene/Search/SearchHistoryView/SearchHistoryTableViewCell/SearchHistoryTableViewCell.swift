//
//  SearchHistoryTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


class SearchHistoryTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }

    func setText(_ text: String?) {
        textLabel?.text = text
    }
    
    private func setupSubViews() {
        textLabel?.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        textLabel?.textColor = UIColor.systemBlue
    }

}
