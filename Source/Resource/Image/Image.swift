//
//  Image.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import UIKit


enum Image {

    case search
    case star_rating_mask
    case star_rating_outline
    case heart
    case share
    case account
    
    var value: UIImage {
        let imageName = String(describing: self)
        guard let image = UIImage(named: imageName) else {
            assertionFailure("Asset Image Not Found")
            return UIImage()
        }
        return image
    }

}
