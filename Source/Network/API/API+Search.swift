//
//  API+Search.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import UIKit


extension API {

    struct Search: AppStoreAPIRequestGet {

        var path: String = "/search"
        var parameters: [String : Any] {
            [
                "country": "kr",
                "media": "software",
                "limit": limit,
                "term": query
            ]
        }
        var responseType = SearchAPIResponse.self
        
        private let limit: Int = 30
        private let query: String
        
        init(query: String) {
            self.query = query
        }

    }

}

struct SearchAPIResponse: Decodable {

    let resultCount: Int
    let results: [AppResponse]

}

struct AppResponse: Decodable {
    
    let trackName: String
    let trackId: Int
    let artistName: String

    let artworkUrl100: String?
    let formattedPrice: String?
    let userRatingCount: Double?
    let averageUserRating: Float?
    let genres: [String]?
    let description: String?
    let price: Double?
    let screenshotUrls: [String]?
    let sellerName: String?
    let fileSizeBytes: String?
    let languageCodesISO2A: [String]?
    let contentAdvisoryRating: String?
    let sellerUrl: String?

}
