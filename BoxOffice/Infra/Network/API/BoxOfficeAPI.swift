enum BoxOfficeAPI {
    case boxOffice
    case movie
    case movieImage(query: String)
}

extension BoxOfficeAPI {
    static let baseUrl = "kobis.or.kr"
    static let basePath = "/kobisopenapi/webservice/rest"
    static let imageBaseUrl = "https://example.com"
    static let imagebasePath = "/v2/search/image"
    
    var path: String {
        switch self {
        case .boxOffice:
            return BoxOfficeAPI.basePath + "/boxoffice/searchDailyBoxOfficeList.json"
        case .movie:
            return BoxOfficeAPI.basePath + "/movie/searchMovieInfo.json"
        case .movieImage(let query):
            return BoxOfficeAPI.imagebasePath + "?query=\(query)"
        }
    }
}
