//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    self.window = .init(windowScene: windowScene)
    let navigationController = UINavigationController(rootViewController: BoxOfficeViewController())
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
  }
}
