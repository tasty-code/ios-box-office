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
        
        let boxOfficeAPIService = BoxOfficeAPIService(provider: NetworkProvider())
        let boxOfficeRepository = DefaultBoxOfficeRepository(apiService: boxOfficeAPIService)
        let boxOfficeViewModel = BoxOfficeViewModel(boxOfficeRepository: boxOfficeRepository)
        let boxOfficeViewController = BoxOfficeViewController(viewModel: boxOfficeViewModel)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: boxOfficeViewController)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

