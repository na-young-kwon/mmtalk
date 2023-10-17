//
//  AppCoordinator.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

final class AppCoordinator: Coordinator {
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    
    init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let pages = TabBarPage.allCases
        let controllers = pages.map { makeTabNavigationController(of: $0) }
        configureTabBar(with: controllers)
    }
    
    private func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageNumber
    }
    
    private func configureTabBar(with vc: [UIViewController]) {
        tabBarController.setViewControllers(vc, animated: false)
        selectPage(.productList)
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .black
        setUpTabBarShadow(with: tabBarController.tabBar)
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
    
    private func setUpTabBarShadow(with tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowOpacity = 0.15
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
