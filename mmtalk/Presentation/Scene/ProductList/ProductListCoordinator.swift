//
//  ProductListCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

final class ProductListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ProductListViewController()
        let productService = ProductService(apiProvider: DefaultAPIProvider())
        let productRepository = DefaultProductRepository(service: productService)
        
        viewController.viewModel = ProductListViewModel(
            useCase: DefaultProductListUseCase(
                productRepository: productRepository
            ),
            coordinator: ProductListCoordinator(navigationController)
        )
        navigationController.pushViewController(viewController, animated: false)
    }
}
