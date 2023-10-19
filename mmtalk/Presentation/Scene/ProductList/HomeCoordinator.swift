//
//  HomeCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ProductListViewController()
        let productService = ProductService(apiProvider: DefaultAPIProvider())
        let productRepository = DefaultProductRepository(service: productService)
        let useCase = ProductUseCase(productRepository: productRepository)
        let coordinator = HomeCoordinator(navigationController)

        let viewModel = ProductListViewModel(
            useCase: useCase,
            coordinator: coordinator
        )
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func pushDetailView(with hash: String) {
        let viewController = ProductDetailViewController()
        let productService = ProductService(apiProvider: DefaultAPIProvider())
        let productRepository = DefaultProductRepository(service: productService)
        let useCase = ProductUseCase(productRepository: productRepository)
        
        let viewModel = ProductDetailViewModel(
            hash: hash,
            useCase: useCase
        )
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
