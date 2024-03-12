enum BoxOfficeAPI {
    case boxOffice
    case movie
    case movieImage
}

extension BoxOfficeAPI {
    static let baseUrl = "kobis.or.kr"
    static let basePath = "/kobisopenapi/webservice/rest"
    static let imageBaseUrl = "dapi.kakao.com"
    static let imagebasePath = "/v2/search/image"
    
    var path: String {
        switch self {
        case .boxOffice:
            return BoxOfficeAPI.basePath + "/boxoffice/searchDailyBoxOfficeList.json"
        case .movie:
            return BoxOfficeAPI.basePath + "/movie/searchMovieInfo.json"
        case .movieImage:
            return BoxOfficeAPI.imagebasePath
        }
    }
}
