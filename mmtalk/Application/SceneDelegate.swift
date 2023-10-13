//
//  SceneDelegate.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        window.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }
}
