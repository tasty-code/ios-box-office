
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        configureURL()
        
        let mainViewController = UINavigationController(rootViewController: DependencyEnvironment.shared.makeBoxOfficeCollectionViewController())
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainViewController
    }
    
    private func configureURL() {
        guard let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest") else {
            return print("url이 생성되지 않았습니다.") }
        BaseURLManager.shared.configure(url, for: .kobis)
    }
}
