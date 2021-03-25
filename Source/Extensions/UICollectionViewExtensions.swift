//
//  UICollectionViewExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import UIKit


extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as! T
    }

}
