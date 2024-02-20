import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kobis.or.kr"
        components.path = "/" + path
        components.queryItems = queryItems
        guard let url = components.url else { preconditionFailure("URLError: \(components)") }
        return url
    }
}

extension EndPoint {
    static var boxOfficePath: Self {
        EndPoint(path: "kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
    }
    static var moviInfoPath: Self {
        EndPoint(path: "kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
    }

}

extension EndPoint {
    mutating func getBoxOfficeQueryItems(targetDate: String) {
        queryItems.append(URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888"))
        queryItems.append(URLQueryItem(name: "targetDt", value: targetDate))
    }
    mutating func getDetailMovieInfoQueryItems(movieCode: String) {
        queryItems.append(URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888"))
        queryItems.append(URLQueryItem(name: "movieCd", value: movieCode))

    }
}
