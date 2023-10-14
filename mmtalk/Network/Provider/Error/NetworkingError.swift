//
//  NetworkingError.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

enum NetworkingError: Error {
    case invalidRequest
    case serverError
    case invalidResponse
    case invalidData
    case parsingError
}
