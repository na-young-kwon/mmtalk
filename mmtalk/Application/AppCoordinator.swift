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
        tabBarController.setViewControllers(vc, animated: false)
        tabBarController.selectedIndex = TabBarPage.productList.pageNumber
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .black
        configureTabBarShadow(tabBar: tabBarController.tabBar)
    }
    
    private func makeTabNavigationController(of page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: page.stringValue,
            image: UIImage(named: page.imageName),
            selectedImage: nil
        )
        startTabCoordinator(of: page, to: navigationController)
        return navigationController
    }
    
    private func startTabCoordinator(of page: TabBarPage, to navigationController: UINavigationController) {
        switch page {
        case .productList:
            let productListCoordinator = ProductListCoordinator(navigationController)
            productListCoordinator.start()
        case .myPage:
            let myPageCoordinator = MyPageCoordinator(navigationController)
            myPageCoordinator.start()
        }
    }
    
    private func configureTabBarShadow(tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.15
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
    }
}
