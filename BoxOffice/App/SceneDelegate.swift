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
    self.window?.rootViewController = makeRootViewController()
    self.window?.makeKeyAndVisible()
  }
  
  private func makeRootViewController() -> UIViewController {
    let session = URLSession.shared
    let networkService = NetworkService(requester: session)
    let decoder = JSONDecoder()
    let repo = MovieRepository(requester: networkService, decoder: decoder)
    let useCase = BoxOfficeUseCase(repository: repo)
    let viewModel = BoxOfficeViewModel(useCase: useCase)
    let viewController = BoxOfficeViewController(viewModel: viewModel)
    viewModel.delegate = viewController
    let navigationController = UINavigationController(rootViewController: viewController)
    return navigationController
  }
}
