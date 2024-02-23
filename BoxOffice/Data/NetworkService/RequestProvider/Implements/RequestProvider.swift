
import Foundation

final class RequestProvider: RequestProvidable {
    
    var httpMethod: String

    init(httpMethod: String) {
        self.httpMethod = httpMethod
    }

    func makeURLRequest(for boxOfficeType: URLProvider) -> URLRequest? {
        guard let url = boxOfficeType.makeURL() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
