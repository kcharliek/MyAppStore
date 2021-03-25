//
//  QuerySuggestionEngine.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


protocol QuerySuggestionEngine {

    func suggestQuery(with hint: String, usesDebouncing: Bool, completion: @escaping (Result<[String], Error>) -> Void)

}
