//
//  ProductListViewModel.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductListViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let products = BehaviorRelay<[Product]>(value: [])
    }
    
    private let useCase: ProductUseCase
    private weak var coordinator: ProductListCoordinator?
    
    init(useCase: ProductUseCase, coordinator: ProductListCoordinator?) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        useCase.products
            .subscribe(onNext: { products in
                output.products.accept(products)
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppear
            .subscribe { _ in
                self.useCase.fetchProducts(for: "0")
            }
            .disposed(by: disposeBag)
        return output
    }
}
