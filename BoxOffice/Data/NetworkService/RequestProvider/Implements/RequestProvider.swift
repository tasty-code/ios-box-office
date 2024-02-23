

import Foundation

class RequestProvider: RequestProvidable {
    
    var httpMethod: String

    init(httpMethod: String) {
        self.httpMethod = httpMethod
    }

    func makeURLRequest() -> URLRequest? {
        guard let url = URLProvider.dailyBoxOffice(date: Date.yesterday.formattedDate(withFormat: "yyyyMMdd")).makeURL() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
