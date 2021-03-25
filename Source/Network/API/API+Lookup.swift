//
//  API+Lookup.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


extension API {

    struct Lookup: AppStoreAPIRequestGet {

        var path: String = "/lookup"
        var parameters: [String : Any] {
            [
                "country": "kr",
                "media": "software",
                "id": "\(trackId)"
            ]
        }
        var responseType = LookupAPIResponse.self

        private var trackId: Int

        init(trackId: Int) {
            self.trackId = trackId
        }

    }

}

struct LookupAPIResponse: Decodable {

    let resultCount: Int
    let results: [AppResponse]

}
