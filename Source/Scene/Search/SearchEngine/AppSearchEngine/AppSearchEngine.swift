//
//  AppSearchEngine.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


protocol AppSearchEngine {

    func searchApp(with query: String, completion: @escaping (Result<[App], Error>) -> Void)

}
