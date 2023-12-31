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
            brand: $0.brand?.trimmingCharacters(in: ["|"]),
            discountRate: String($0.discountRate),
            sellPrice: String($0.sellPrice.decimalFormat ?? "0"),
            reviewCount: String($0.reviewCount),
            reviewAverage: String($0.reviewAverage),
            tags: $0.tags,
            imageURL: $0.imageURL,
            isSoldOut: $0.soldOut
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
        let reviewAverage: Double
        let tags: [Tag]
        let discountRate: Int
        let soldOut: Bool
        private let partnerNo: Int
        private let normalPrice: Int
        
        
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
