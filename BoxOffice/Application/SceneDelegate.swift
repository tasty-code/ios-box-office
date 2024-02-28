import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let sessionMananger = DefaultNetworkSessionManager()
        let networkService = DefaultNetworkService(sessionManager: sessionMananger)
        let dataTransferService = DefaultDataTransferService(with: networkService)
        let boxOfficeRepository = DefaultBoxOfficeRepository(dataTransferService: dataTransferService)
        let boxOfficeUseCase = DefaulBoxOfficeUseCase(boxOfficeRepository: boxOfficeRepository)
        let movieListViewModel = MoviesListViewModel(useCase: boxOfficeUseCase)
        
        let navigationController = UINavigationController(rootViewController: MoviesCollectionView(viewModel: movieListViewModel))
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
