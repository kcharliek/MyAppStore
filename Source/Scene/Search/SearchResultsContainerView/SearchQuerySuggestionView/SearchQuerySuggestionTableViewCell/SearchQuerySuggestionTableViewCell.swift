
//  SearchQuerySuggestionTableViewCell.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import UIKit


class SearchQuerySuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(text: String) {
        self.titleLabel.text = text
    }

}
