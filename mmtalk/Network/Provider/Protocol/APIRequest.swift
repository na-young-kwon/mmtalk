//
//  APIRequest.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

protocol APIRequest {
    associatedtype Response: APIResponse
    
    var httpMethod: HTTPMethod { get }
    var urlHost: String { get }
    var urlPath: String { get }
    var parameters: [String: String] { get }
    var headers: [String: String]? { get }
}

extension APIRequest {
    var url: URL? {
        var urlComponents = URLComponents(string: urlHost + urlPath)
        let queries = parameters.map { URLQueryItem(name: $0, value: $1) }
        urlComponents?.queryItems = queries
        
        guard let url = urlComponents?.url else {
            return nil
        }
        return url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let headers = headers {
            headers.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
