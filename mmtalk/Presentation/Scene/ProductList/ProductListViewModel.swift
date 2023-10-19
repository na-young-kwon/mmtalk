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
        let itemSelected: Observable<Product?>
        let fetchMoreProduct: Observable<Void>
    }
    
    struct Output {
        let products = BehaviorRelay<[Product]>(value: [])
    }
    
    private let useCase: ProductUseCase
    private let coordinator: HomeCoordinator
    
    init(useCase: ProductUseCase, coordinator: HomeCoordinator) {
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
            .compactMap { $0 }
            .subscribe { [weak self] product in
                self?.coordinator.pushDetailView(with: product.hash)
            }
            .disposed(by: disposeBag)
        
        input.fetchMoreProduct
            .subscribe { [weak self] product in
                self?.useCase.fetchProducts()
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
