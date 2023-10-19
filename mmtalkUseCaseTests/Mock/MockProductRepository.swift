//
//  MockProductRepository.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/18.
//

import UIKit
import RxSwift

final class MockProductRepository: ProductRepository {
    private let jsonDecoder = JSONDecoder()
    
    func fetchProductList(for offset: Int) -> Observable<ProductListDTO> {
        return Observable.create { observer in
            do {
                let json = NSDataAsset(name: "mmtalk_productList")!
                let productList = try self.jsonDecoder.decode(ProductListDTO.self, from: json.data)
                observer.onNext(productList)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetchProductDetail(for hash: String) -> Observable<ProductDetailDTO> {
        return Observable.create { observer in
            do {
                let json = NSDataAsset(name: "mmtalk_productDetail")!
                let productDetail = try self.jsonDecoder.decode(ProductDetailDTO.self, from: json.data)
                observer.onNext(productDetail)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
