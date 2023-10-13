//
//  AppCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let tabBarController = UITabBarController()
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let pages = TabBarPage.allCases
        let controllers = pages.map { makeTabNavigationController(of: $0) }
        configureTabBar(with: controllers)
        showTabBar()
    }
    
    private func showTabBar() {
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
        let nav = UINavigationController()
        nav.tabBarItem = UITabBarItem(title: page.stringValue, image: nil, selectedImage: nil)
        return nav
    }
}

