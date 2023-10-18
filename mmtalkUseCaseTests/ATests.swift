//
//  ATests.swift
//  mmtalkUseCaseTests
//
//  Created by 권나영 on 2023/10/18.
//

import XCTest
import RxSwift
import RxCocoa

final class ATests: XCTestCase {

    private var useCase: ProductUseCase!
    private var disposeBag: DisposeBag!
    private var repository: MockProductRepository!
    
    override func setUpWithError() throws {
        useCase = ProductUseCase(productRepository: MockProductRepository())
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        useCase = nil
        repository = nil
        disposeBag = nil
    }
    
    func test_productList_success() {
        useCase.fetchProducts()
        useCase.products
            .subscribe(onNext: { product in
                XCTAssertEqual(product.count, 219)
            })
            .disposed(by: disposeBag)
    }

    func testPerformanceExample() {
        XCTAssertEqual(1, 219)
    }

}
