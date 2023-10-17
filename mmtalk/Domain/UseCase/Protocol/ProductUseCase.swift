//
//  ProductUseCase.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductUseCase {
    var productDetail: PublishSubject<ProductDetail> { get }
    var products: BehaviorRelay<[Product]> { get }
    func fetchProducts()
    func fetchProductDetail(for hash: String)
}
