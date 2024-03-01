
import Foundation

enum URLProvider: URLProvidable {
    
    case dailyBoxOffice(date: String)
    case detailMovieInformation(code: String)
    
    func makeURL() -> URL? {
        switch self {
        case .dailyBoxOffice(date: let date):
            return makeComponents(with: "/boxoffice/searchDailyBoxOfficeList.json", byTarget: "targetDt", andValue: date)?.url
        case .detailMovieInformation(code: let code):
            return makeComponents(with: "/movie/searchMovieInfo.json", byTarget: "movieCd", andValue: code)?.url
        }
    }

    private func makeComponents(with path: String, byTarget target: String, andValue targetValue: String) -> URLComponents? {
        guard let baseURL = BaseURLManager.shared.get(for: .kobis) else { return nil }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let path = path
        components?.path += path
        
        components?.queryItems = [
            URLQueryItem(name: "key", value: ENV.API_KEY),
            URLQueryItem(name: "\(target)", value: "\(targetValue)")
        ]
        return components
    }
}

