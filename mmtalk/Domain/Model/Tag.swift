//
//  Tag.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

enum Tag: String, Decodable {
    case best = "BEST"
    case freeDelivery = "FREE_DELIVERY"
    
    var description: String {
        switch self {
        case .best:
            return "BEST"
        case .freeDelivery:
            return "무료배송"
        }
    }
}
