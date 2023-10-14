//
//  ProductListDTO.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

struct ProductListDTO: APIResponse {
    let meta: Meta
    let products: [Product]
}

// Meta
struct Meta: Decodable {
    let offset: Int
    let limit: Int
    let isFinal: Bool
}

// Product
struct Product: Decodable {
    let hash: String
    let name: String
    let brand: String?
    let sellPrice: Int
    let normalPrice: Int
    let soldOut: Bool
    let imageURL: String
    let reviewCount: Int
    let reviewAverage: Int
    let partnerNo: Int
    let tags: [Tag]
    let discountRate: Int
    
    enum CodingKeys: String, CodingKey {
        case hash, name, brand, soldOut
        case reviewCount, partnerNo, tags, discountRate
        case sellPrice = "sellPrc"
        case normalPrice = "normalPrc"
        case imageURL = "imgUrl"
        case reviewAverage = "reviewAvg"
    }
}

// Tag
enum Tag: String, Decodable {
    case best = "BEST"
    case freeDelivery = "FREE_DELIVERY"
}
