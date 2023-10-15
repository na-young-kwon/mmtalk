//
//  DefaultProductListUseCase.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift

final class DefaultProductUseCase: ProductUseCase {
    private let productRepository: ProductRepository
    private let disposeBag = DisposeBag()
    
    var productDetail = PublishSubject<ProductDetail>()
    var products = BehaviorSubject<[Product]>(value: [])
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func fetchProducts(for offset: String) {
        productRepository.fetchProductList(for: offset)
            .subscribe(onNext: { productListDTO in
                self.products.onNext(productListDTO.productList)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchProductDetail(for hash: String) {
        productRepository.fetchProductDetail(for: hash)
            .subscribe(onNext: { productDetailDTO in
                let detail = ProductDetail(title: productDetailDTO.name)
                self.productDetail.onNext(detail)
            })
            .disposed(by: disposeBag)
    }
}
