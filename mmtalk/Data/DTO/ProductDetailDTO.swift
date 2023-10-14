//
//  ProductDetailDTO.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

struct ProductDetailDTO: APIResponse {
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
    let deliveryDetail: DeliveryDetail
    let deliveryAreaDetails: [DeliveryAreaDetails]

    enum CodingKeys: String, CodingKey {
        case hash, name, brand, soldOut, reviewCount, partnerNo
        case tags, discountRate, deliveryDetail, deliveryAreaDetails
        case sellPrice = "sellPrc"
        case normalPrice = "normalPrc"
        case imageURL = "imgUrl"
        case reviewAverage = "reviewAvg"
    }
    
    struct DeliveryDetail: Decodable {
        let isFree: Bool
        let freeLimit: Int
        let deliveryFee: Int
        let isBillingByAreaWhenFree: Bool
        let basedBy: String
    }
    
    struct DeliveryAreaDetails: Decodable {
        let sido: String
        let gugun: String
        let dong: String
        let addPrice: Int
    }
}
