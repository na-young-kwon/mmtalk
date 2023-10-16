//
//  Product.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

struct Product: Hashable {
    let id = UUID()
    let hash: String
    let name: String
    let brand: String?
    let discountRate: String
    let sellPrice: String
    let reviewCount: String
    let reviewAverage: String
    let tags: [Tag]
    let imageURL: String
}
