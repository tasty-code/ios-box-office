

import Foundation

class RequestProvider: RequestProvidable {
    
    var httpMethod: String

    init(httpMethod: String) {
        self.httpMethod = httpMethod
    }

    func makeURLRequest() -> URLRequest? {
        guard let url = URLProvider.dailyBoxOffice(date: "20230303").makeURL() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
