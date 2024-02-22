

import Foundation

enum RequestProvider: URLRequestProtocol {
    case dailyBoxOffice(date: Date)
    
    func makeURLRequest(httpMethod: String) -> URLRequest {
        switch self {
        case .dailyBoxOffice(let date):
            let targetDate = "20240221" 
            let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(ENV.API_KEY)&targetDt=\(targetDate)"
            return setRequest(urlString: urlString, httpMethod: httpMethod)
        }
    }
    
    private func setRequest(urlString: String, httpMethod: String) -> URLRequest {
        guard let url = URL(string: urlString) else { fatalError("wrong url")}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
