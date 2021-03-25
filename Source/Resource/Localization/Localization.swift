//
//  Localization.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import Foundation


enum Text {

    case search_bar_placeholder
    case search
    case recent_searches
    case screenshots
    case information
    case provider
    case file_size
    case category
    case language
    case number_of_language
    case developr_website
    case developer
    case purchase
    case number_of_review
    case age
    case age_suffix
    case no_data
    case in_app_purchase

    var value: String {
        String(describing: self).localized
    }
}

extension String {

     var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
     }

}
