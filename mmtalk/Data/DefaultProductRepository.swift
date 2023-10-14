//
//  DefaultProductListRepository.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

final class DefaultProductRepository: ProductRepository {
    private let service: ProductService
    
    init(service: ProductService) {
        self.service = service
    }
    
    func fetchProductList(for offset: String) -> Observable<ProductListDTO> {
        service.fetchProductList(offset: offset)
    }
    
    func fetchProductDetail(for hash: String) -> Observable<ProductDetailDTO> {
        service.fetchProductDetail(for: hash)
    }
}
