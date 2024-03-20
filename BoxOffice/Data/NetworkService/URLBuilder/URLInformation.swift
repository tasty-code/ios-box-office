
import Foundation

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
        var urlQueryItems: [URLQueryItem] = []
        
        switch self {
        case .daily(let date):
            urlQueryItems.append(URLQueryItem(name: "key", value: ENV.APIKey))
            urlQueryItems.append(URLQueryItem(name: "targetDt", value: date))
        case .detail(let code):
            urlQueryItems.append(URLQueryItem(name: "key", value: ENV.APIKey))
            urlQueryItems.append(URLQueryItem(name: "movieCd", value: code))
        }
        
        return urlQueryItems
    }
}
