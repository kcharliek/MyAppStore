//
//  Networking.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


internal enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

}

internal protocol APIRequest {

    associatedtype APIResponse: Decodable
    
    var method: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var query: [String: Any] { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    var responseType: APIResponse.Type { get }

    func parse(_ response: [String: Any]) throws -> APIResponse

}

protocol APIRequestPost: APIRequest {

    var parameters: [String: Any] { get }

}

extension APIRequestPost {

    var method: HTTPMethod {
        .post
    }

    var body: Data? {
        try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    }

}

protocol APIRequestGet: APIRequest {

    var parameters: [String: Any] { get }

}

extension APIRequestGet {

    var method: HTTPMethod {
        .get
    }

    var query: [String : Any] {
        parameters
    }
    
    var body: Data? {
        nil
    }

}

extension APIRequest {

    var url: URL? {
        var urlComponents = URLComponents(string: baseURLString + path)
        urlComponents?.queryItems = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return urlComponents?.url
    }

    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }

    func execute(_ completion: ((Result<APIResponse, Error>) -> Void)?) {
        guard let urlRequest = self.urlRequest else {
            completion?(.failure(APIError.invalidURL))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let error = error {
                completion?(.failure(error))
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            else {
                completion?(.failure(APIError.invalidResponseData))
                return
            }

            do {
                let object = try parse(json)
                completion?(.success(object))
            } catch (let error) {
                completion?(.failure(error))
            }
        }
        dataTask.resume()
    }

    func parse(_ response: [String: Any]) throws -> APIResponse {
        let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
        let response = try JSONDecoder().decode(APIResponse.self, from: data)
        return response
    }

}
