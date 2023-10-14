//
//  MyPageCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MyPageViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
