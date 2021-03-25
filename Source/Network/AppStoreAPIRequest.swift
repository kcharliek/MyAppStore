//
//  AppStoreAPIRequest.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


protocol AppStoreAPIRequestPost: APIRequestPost, AppStoreAPIRequestInfoOwner { }

protocol AppStoreAPIRequestGet: APIRequestGet, AppStoreAPIRequestInfoOwner { }

protocol AppStoreAPIRequestInfoOwner { }

extension AppStoreAPIRequestInfoOwner {

    var baseURLString: String {
        "https://itunes.apple.com"
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }

}
