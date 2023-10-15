//
//  ProductRepository.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

protocol ProductRepository {
    func fetchProductList(for offset: Int) -> Observable<ProductListDTO>
    func fetchProductDetail(for hash: String) -> Observable<ProductDetailDTO>
}
