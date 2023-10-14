//
//  ProductListRequest.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

struct ProductListRequest: APIRequest {
    typealias Response = ProductListDTO
    
    let httpMethod: HTTPMethod = .get
    let urlHost = "https://assignment.mobile.mmtalk.kr/rest/"
    let urlPath = "shopping/products?"
    let offset: String
    let limit = "20"
    var headers: [String : String]? {[
        "authorization": "Bearer 2G8QgQ5RCM",
        "Content-Type": "application/json"
    ]}
    var parameters: [String : String] {[
        "offset": offset,
        "limit": limit
    ]}
}
