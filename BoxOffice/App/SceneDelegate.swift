
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        configureURL()
        
        let mainViewController = DependencyEnvironment.shared.makeBoxOfficeCollectionViewController()
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainViewController
    }
    
    private func configureURL() {
        let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest")!
        BaseURLManager.shared.configure(url, for: .kobis)
    }
}
