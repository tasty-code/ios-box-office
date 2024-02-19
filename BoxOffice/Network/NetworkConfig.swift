import Foundation

enum URLSCheme: String {
    case https = "https"
}

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol NetworkConfigurable {
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: String] { get }
    var method: HTTPMethodType { get }
    
    func toURLComponents() -> URLComponents
}

struct ApiDataNetworkConfig {
    let baseURL: String
    let path: String
    let queryParameters: [String: String]
    let method: HTTPMethodType
    
     init(
        baseURL: String,
        path: String,
        queryParameters: [String: String] = [:],
        method: HTTPMethodType = .get
     ) {
        self.baseURL = baseURL
        self.path = path
        self.queryParameters = queryParameters
        self.method = method
    }
}

extension ApiDataNetworkConfig: NetworkConfigurable {
    func toURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = URLSCheme.https.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }
        return components
    }
}
