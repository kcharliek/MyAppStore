//
//  UIImageViewExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/22.
//

import UIKit


enum UIImageViewError: Error {

    case invalidURL
    case invalidData

}

extension UIImageView {

    func load(url: URL?, placeholderImage: UIImage? = nil, completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        load(url: url, placeholder: placeholderImage, placeholderColor: nil, completion: completion)
    }

    func load(url: URL?, placeholderColor: UIColor? = nil, completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        load(url: url, placeholder: nil, placeholderColor: placeholderColor, completion: completion)
    }

    private func load(url: URL?, placeholder: UIImage?, placeholderColor: UIColor?, completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        image = placeholder
        backgroundColor = placeholderColor

        guard let url = url else {
            completion?(.failure(UIImageViewError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion?(.failure(error))
                return
            }

            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    completion?(.failure(UIImageViewError.invalidData))
                    return
                }

                self.image = image
                self.backgroundColor = nil
                completion?(.success(image))
            }
        }).resume()
    }

}
