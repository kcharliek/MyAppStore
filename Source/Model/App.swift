//
//  App.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import UIKit


struct App {

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

extension App {

    var iconImageURL: URL? {
        return artworkUrl100.flatMap { URL(string: $0) }
    }

    var hasRating: Bool {
        if let userRatingCount = userRatingCount {
            return userRatingCount.isZero == false
        }
        return false
    }

}

class AppConverter {

    static func convert(appResponse: AppResponse) -> App {
        return App(
            trackName: appResponse.trackName,
            trackId: appResponse.trackId,
            artistName: appResponse.artistName,
            artworkUrl100: appResponse.artworkUrl100,
            formattedPrice: appResponse.formattedPrice,
            userRatingCount: appResponse.userRatingCount,
            averageUserRating: appResponse.averageUserRating,
            genres: appResponse.genres,
            description: appResponse.description,
            price: appResponse.price,
            screenshotUrls: appResponse.screenshotUrls,
            sellerName: appResponse.sellerName,
            fileSizeBytes: appResponse.fileSizeBytes,
            languageCodesISO2A: appResponse.languageCodesISO2A,
            contentAdvisoryRating: appResponse.contentAdvisoryRating,
            sellerUrl: appResponse.sellerUrl
        )
    }

}
