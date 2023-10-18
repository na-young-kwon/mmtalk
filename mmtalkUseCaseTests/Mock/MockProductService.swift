//
//  MockProductService.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/18.
//

import Foundation
import RxSwift

final class MockProductService: ProductService {
    func fetchProductList(for offset: String) -> Observable<ProductListDTO> {
        return Observable.just(ProductListDTO(from: <#T##Decoder#>))
    }
    
    func fetchProductDetail(for hash: String) -> Observable<ProductDetailDTO> {
        <#code#>
    }
}
