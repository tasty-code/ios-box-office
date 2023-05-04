//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by M&A on 13/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
        
        let rootViewController = DIContainer.shared.makeBoxOfficeListController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
    }
}
