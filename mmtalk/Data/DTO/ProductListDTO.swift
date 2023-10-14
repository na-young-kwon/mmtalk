//
//  ProductListDTO.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

struct ProductListDTO: APIResponse {
    private let meta: Meta
    private let products: [ProductList]
    
    var productList: [Product] {
        if products.isEmpty {
            return []
        }
        return products.map { Product(
            hash: $0.hash,
            name: $0.name,
            brand: $0.brand,
            discountRate: String($0.discountRate),
            sellPrice: String($0.sellPrice),
            reviewCount: String($0.reviewCount),
            reviewAverage: String($0.reviewAverage),
            tags: $0.tags,
            imageURL: $0.imageURL
        )}
    }
    
    // Meta
    private struct Meta: Decodable {
        let offset: Int
        let limit: Int
        let isFinal: Bool
    }
    
    // Product
    struct ProductList: Decodable {
        let hash: String
        let name: String
        let brand: String?
        let sellPrice: Int
        let imageURL: String
        let reviewCount: Int
        let reviewAverage: Int
        let tags: [Tag]
        let discountRate: Int
        private let partnerNo: Int
        private let normalPrice: Int
        private let soldOut: Bool
        
        enum CodingKeys: String, CodingKey {
            case hash, name, brand, soldOut
            case reviewCount, partnerNo, tags, discountRate
            case sellPrice = "sellPrc"
            case normalPrice = "normalPrc"
            case imageURL = "imgUrl"
            case reviewAverage = "reviewAvg"
        }
    }
}
