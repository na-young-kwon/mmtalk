//
//  Reusable.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}
