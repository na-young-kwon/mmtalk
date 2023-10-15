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
        let fetchMoreProduct: Observable<Void>
        let itemSelected: Observable<Product>
    }
    
    struct Output {
        let products = BehaviorRelay<[Product]>(value: [])
    }
    
    private let useCase: ProductUseCase
    private let coordinator: ProductListCoordinator
    
    init(useCase: ProductUseCase, coordinator: ProductListCoordinator) {
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
                self.useCase.fetchProducts()
            }
            .disposed(by: disposeBag)
        
        input.itemSelected
            .subscribe { [weak self] product in
                self?.coordinator.pushDetailView(with: product.hash)
            }
            .disposed(by: disposeBag)
        
        input.fetchMoreProduct
            .subscribe { product in
                self.useCase.fetchProducts()
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
