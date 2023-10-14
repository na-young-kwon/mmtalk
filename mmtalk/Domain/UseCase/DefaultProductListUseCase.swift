//
//  DefaultProductListUseCase.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

final class DefaultProductListUseCase: ProductListUseCase {
    private let productRepository: ProductRepository
    private let disposeBag = DisposeBag()
    
    var products = BehaviorSubject<[Product]>(value: [])
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func fetchProducts(for offset: String) {
        productRepository.fetchProductList(for: offset)
            .subscribe(onNext: { products in
                print(products)
            })
            .disposed(by: disposeBag)
    }
}
