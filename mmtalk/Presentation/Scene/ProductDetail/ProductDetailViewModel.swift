//
//  ProductDetailViewModel.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import Foundation
import RxSwift

final class ProductDetailViewModel: ViewModelType {
    private let hash: String
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let product = PublishSubject<ProductDetail>()
    }
    
    private let useCase: ProductUseCase
    
    init(hash: String, useCase: ProductUseCase) {
        self.hash = hash
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        useCase.productDetail
            .subscribe(onNext: { product in
                output.product.onNext(product)
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppear
            .subscribe { _ in
                self.useCase.fetchProductDetail(for: self.hash)
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
