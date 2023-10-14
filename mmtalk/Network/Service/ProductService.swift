//
//  ProductService.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

final class ProductService {
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchProductList(offset: String) -> Observable<ProductListDTO> {
        let request = ProductListRequest(offset: offset)
        return apiProvider.requestTask(with: request)
    }
}
