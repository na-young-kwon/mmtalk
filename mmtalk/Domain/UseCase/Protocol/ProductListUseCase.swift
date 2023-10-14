//
//  ProductListUseCase.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

protocol ProductListUseCase {
    var products: BehaviorSubject<[Product]> { get }
    func fetchProducts(for offset: String)
}
