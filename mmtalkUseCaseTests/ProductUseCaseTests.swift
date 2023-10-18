//
//  mmtalkTests.swift
//  mmtalkTests
//
//  Created by 권나영 on 2023/10/14.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa

class ProductUseCaseTests: XCTestCase {
    private var scheduler: TestScheduler!
    private var useCase: ProductUseCase!
    private var disposeBag: DisposeBag!
    private var repository: MockProductRepository!
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        useCase = ProductUseCase(productRepository: MockProductRepository())
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        useCase = nil
        repository = nil
        disposeBag = nil
    }
    
    func test_fetch_product_list_success() {
        let productListCountOutput = scheduler.createObserver(Int.self)
        
        scheduler.createColdObservable([
            .next(10, ())
        ]).subscribe(onNext: { [weak self] in
            self?.useCase.fetchProducts()
        })
        .disposed(by: disposeBag)
        
        useCase.products
            .map { $0.count }
            .subscribe(productListCountOutput)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(productListCountOutput.events, [
            .next(0, 0),
            .next(10,20)
        ])
    }
    
    func test_check_product_hash_match() {
        let productHashOutput = scheduler.createObserver(String.self)
        
        scheduler.createColdObservable([
            .next(10, ())
        ]).subscribe(onNext: { [weak self] in
            self?.useCase.fetchProducts()
        })
        .disposed(by: disposeBag)
        
        useCase.products
            .compactMap { $0.first.map { $0.hash } }
            .subscribe(productHashOutput)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(productHashOutput.events, [
            .next(10, "9201921952970CB78C9FBF5EC623F263")
        ])
    }
    
    func test_current_page_get_added_after_fetching() {
        XCTAssertEqual(useCase.currentPage, 0)
        
        useCase.fetchProducts()
        
        useCase.products
            .subscribe(onNext: { [weak self] _ in
                XCTAssertEqual(self?.useCase.currentPage, 1)
            })
            .disposed(by: disposeBag)
    }
    
    func test_fetch_product_detail_success() {
        let productDetailOutput = scheduler.createObserver(ProductDetail.self)
        
        scheduler.createColdObservable([
            .next(10, ())
        ]).subscribe(onNext: { [weak self] in
            self?.useCase.fetchProductDetail(for: "9201921952970CB78C9FBF5EC623F263")
        })
        .disposed(by: disposeBag)
        
        useCase.productDetail
            .subscribe(productDetailOutput)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(productDetailOutput.events, [
            .next(10, ProductDetail(title: "[~10/17특가] 디드롭스 베이비 비타민D 400 IU 2.5ml x 1개"))
        ])
    }
}
