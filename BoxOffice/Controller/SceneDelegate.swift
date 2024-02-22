//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let urlSession: URLSession = URLSession.shared
        let networkManager: NetworkManager = NetworkManager(urlSession: urlSession)
        let viewController = BoxOfficeViewController(networkManager: networkManager, loadingIndicatorView: UIActivityIndicatorView())
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

