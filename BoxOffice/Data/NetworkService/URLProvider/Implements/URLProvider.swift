
import Foundation


enum URLProvider: URLProvidable {
    
    case dailyBoxOffice(date: String)
    
    func makeURL() -> URL? {
        guard let baseURL = BaseURLManager.shared.get(for: .kobis) else { return nil }
        
        switch self {
        case .dailyBoxOffice(date: let date):
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            let path = "/boxoffice/searchDailyBoxOfficeList.json"
            components?.path += path
            
            components?.queryItems = [
                URLQueryItem(name: "key", value: ENV.API_KEY),
                URLQueryItem(name: "targetDt", value: date)
            ]
            
            return components?.url
        }
    }
}

