//
//  ProductDetailCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import Foundation
import UIKit

final class ProductDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(with hash: String) {
        let viewController = ProductDetailViewController()
        let productService = ProductService(apiProvider: DefaultAPIProvider())
        let productRepository = DefaultProductRepository(service: productService)
        let useCase = ProductUseCase(productRepository: productRepository)
        let coordinator = ProductDetailCoordinator(navigationController)
        
        let viewModel = ProductDetailViewModel(
            hash: hash,
            useCase: useCase,
            coordinator: coordinator
        )
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
