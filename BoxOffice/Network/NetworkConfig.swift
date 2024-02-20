import Foundation

enum URLSCheme: String {
    case https
}

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol Requestable {
    associatedtype Response
    
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: Any] { get }
    var method: HTTPMethodType { get }
    var bodyParameters: [String: Any] { get }
    var responseDecoder: ResponseDecoder { get }
    
    func toURLComponents() -> URLComponents
}

struct APIConfig<R>: Requestable {
    typealias Response = R
    
    let baseURL: String
    let path: String
    let queryParameters: [String: Any]
    let method: HTTPMethodType
    let bodyParameters: [String: Any]
    let responseDecoder: ResponseDecoder
    
    init(baseURL: String,
         path: String,
         queryParameters: [String: Any] = [:],
         method: HTTPMethodType = .get,
         bodyParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoder  = JSONResponseDecoder()
     ) {
        self.baseURL = baseURL
        self.path = path
        self.queryParameters = queryParameters
        self.method = method
        self.bodyParameters = bodyParameters
        self.responseDecoder = responseDecoder
    }
}

extension APIConfig {
    func toURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = URLSCheme.https.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1 as? String) }
        return components
    }
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
