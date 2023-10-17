//
//  ProductDetailRequest.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

struct ProductDetailRequest: APIRequest {
    typealias Response = ProductDetailDTO
    
    private let apiKey = Bundle.main.apiKey
    let httpMethod: HTTPMethod = .get
    let urlHost = "https://assignment.mobile.mmtalk.kr/rest/"
    let hash: String
    var urlPath: String {
        return "shopping/product/\(hash)"
    }
    var parameters: [String : String] {[:]}
    var headers: [String : String]? {[
        "authorization": apiKey
    ]}
}
