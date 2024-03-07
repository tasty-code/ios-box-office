import Foundation

class URLBuilder: URLBuilderProtocol {

    var baseURL: URL?
    var queryItems = [URLQueryItem]()
    var path = String()
    
    var baseURLProvider: BaseURLProvidable
    
    init(baseURLProvider: BaseURLProvidable) {
        self.baseURLProvider = baseURLProvider
    }
    
    func setBaseURL(type: BaseURLType) -> Self {
        if let baseURL = baseURLProvider.get(for: type) {
            self.baseURL = baseURL
        }
        return self
    }

    func setPath(_ path: String) -> Self {
        self.path = path
        return self
    }

    func setApiKey(apiKey: String) -> Self {
        let queryItem = URLQueryItem(name: "key", value: apiKey)
        queryItems.append(queryItem)
        return self
    }

    func addQueryItem(name: String, value: String?) -> Self {
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        return self
    }


    func build() -> URL? {
        guard let baseURL else { return nil }
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        return components?.url
    }
}


class KobisBuilder: URLBuilder {
    override init(baseURLProvider: BaseURLProvidable) {
        super.init(baseURLProvider: baseURLProvider)
        
    }
}
