//
//  AppCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let pages = TabBarPage.allCases
        let controllers = pages.map { makeTabNavigationController(of: $0) }
        configureTabBar(with: controllers)
        configureRootView()
    }
    
    private func configureRootView() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func configureTabBar(with vc: [UIViewController]) {
        tabBarController.setViewControllers(vc, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageNumber
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .black
    }
    
    private func makeTabNavigationController(of page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: page.stringValue, image: UIImage(named: page.imageName), selectedImage: nil)
        navigationController.pushViewController(ViewController(), animated: false)
        return navigationController
    }
}

