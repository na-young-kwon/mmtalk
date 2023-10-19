//
//  DefaultProductListUseCase.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductUseCase {
    private let productRepository: ProductRepository
    private let disposeBag = DisposeBag()
    
    var productDetail = PublishSubject<ProductDetail>()
    var products = BehaviorRelay<[Product]>(value: [])
    var currentPage = 0
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func fetchProducts() {
        productRepository.fetchProductList(for: currentPage)
            .subscribe(onNext: { productListDTO in
                self.products.accept(self.products.value + productListDTO.productList)
                self.currentPage += 1
            })
            .disposed(by: disposeBag)
    }
    
    func fetchProductDetail(for hash: String) {
        productRepository.fetchProductDetail(for: hash)
            .subscribe(onNext: { [weak self] productDetailDTO in
                let detail = ProductDetail(title: productDetailDTO.name)
                self?.productDetail.onNext(detail)
            })
            .disposed(by: disposeBag)
    }
}
