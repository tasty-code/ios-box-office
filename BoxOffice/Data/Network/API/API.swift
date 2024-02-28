import Foundation

struct API {
    static func boxOfficeAPI() -> APIConfig<BoxOfficeResponseDTO> {
        return .init(baseURL: BoxOfficeAPI.baseUrl,
                     path: BoxOfficeAPI.boxOffice.path,
                     queryParameters: [
                        "key": Bundle.main.apiKey,
                        "targetDt": Date().yesterdayString])
    }
    
    static func movieAPI(with movieCode: String) -> APIConfig<MovieDetailResponseDTO> {
        return .init(baseURL: BoxOfficeAPI.baseUrl,
                     path: BoxOfficeAPI.movie.path,
                     queryParameters: [
                        "key": Bundle.main.apiKey,
                        "movieCd": movieCode])
    }
}
