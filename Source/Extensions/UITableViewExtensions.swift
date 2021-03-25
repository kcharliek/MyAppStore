//
//  UITableViewExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import UIKit


extension UITableView {

    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cellClass.className, for: indexPath) as! T
    }

}
