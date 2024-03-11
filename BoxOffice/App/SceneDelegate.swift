
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let viewControllerFactory:ViewControllerFactoryProtocol = DependencyEnvironment()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainViewController = UINavigationController(rootViewController: viewControllerFactory.makeBoxOfficeCollectionViewController())
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainViewController
    }
}
