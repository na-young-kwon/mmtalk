//
//  APIProvider.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

protocol APIProvider {
    var session: URLSession { get }
    func requestTask<T: APIRequest>(with requestType: T) -> Observable<T.Response>
}
