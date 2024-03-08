
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
        guard let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest") else {
            return print("url이 생성되지 않았습니다.") }
        BaseURLManager.shared.configure(url, for: .kobis)
    }
}

protocol EndPointMakable {
    var url: URL? { get }
}

struct EndPoint: EndPointMakable {
    init(urlInformation: URLInformation) {
        self.urlInformation = urlInformation
    }
    
    private let urlInformation: URLInformation
    private let scheme: String = "http"
    private let host: String = "www.kobis.or.kr"
    
    var url: URL? {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = urlInformation.path
        urlComponent.queryItems = urlInformation.queryItems
        return urlComponent.url
    }

    enum URLInformation {
        case daily(date: String)
        case month(date: String)
        
        var path: String {
            switch self {
            case .daily:
                return ""
            case .month:
                return ""
            }
        }
        
        var queryItems: [URLQueryItem] {
            var urlQueryItems = [URLQueryItem(name: "key", value: ENV.API_KEY)]
            
            switch self {
            case .daily(let date):
                urlQueryItems.append(URLQueryItem(name: "fsdf", value: date))
            case .month(let date):
                urlQueryItems.append(URLQueryItem(name: "fsdf", value: date))
            }
            
            return urlQueryItems
        }
    }
}
