//
//  aProductService.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/18.
//

import Foundation
import RxSwift

protocol ProductService {
    func fetchProductList(for offset: String) -> Observable<ProductListDTO>
    func fetchProductDetail(for hash: String) -> Observable<ProductDetailDTO>
}
