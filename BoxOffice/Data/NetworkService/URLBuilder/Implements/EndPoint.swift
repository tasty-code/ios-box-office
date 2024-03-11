
import Foundation

struct EndPoint: EndPointMakable {
    let apiHost: String
    
    init(urlInformation: URLInformation, apiHost: APIHostType) {
        self.urlInformation = urlInformation
        self.apiHost = apiHost.rawValue
    }
    
    private let urlInformation: URLInformation
    private let scheme: String = "https"
    
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = apiHost
        urlComponent.path = urlInformation.path
        urlComponent.queryItems = urlInformation.queryItems
        return urlComponent.url
    }
    
    enum URLInformation {
        case daily(date: String)
        case detail(code: String)
        
        var path: String {
            switch self {
            case .daily:
                return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            case .detail:
                return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            }
        }
        
        var queryItems: [URLQueryItem] {
            var urlQueryItems = [URLQueryItem(name: "key", value: ENV.API_KEY)]
            
            switch self {
            case .daily(let date):
                urlQueryItems.append(URLQueryItem(name: "targetDt", value: date))
            case .detail(let code):
                urlQueryItems.append(URLQueryItem(name: "movieCd", value: code))
            }
            return urlQueryItems
        }
    }
}
