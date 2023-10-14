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
}

extension APIRequest {
    var url: URL? {
        var urlComponents = URLComponents(string: self.urlHost + self.urlPath)
        let queries = self.parameters.map { URLQueryItem(name: $0, value: $1) }
        urlComponents?.queryItems = queries
        
        guard let url = urlComponents?.url else {
            return nil
        }
        return url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        return request
    }
}
