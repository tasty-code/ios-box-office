import Foundation

struct API {
    static func boxOfficeAPI() -> APIConfig<BoxOfficeResponseDTO> {
        return .init(baseURL: BoxOfficeAPI.baseUrl,
                     path: BoxOfficeAPI.boxOffice.path,
                     queryParameters: [
                        "key": Bundle.main.apiKey,
                        "targetDt": Date().yesterdayString(with: DateFormatter.yyyyMMdd)])
    }
    
    static func movieAPI(with movieCode: String) -> APIConfig<MovieDetailResponseDTO> {
        return .init(baseURL: BoxOfficeAPI.baseUrl,
                     path: BoxOfficeAPI.movie.path,
                     queryParameters: [
                        "key": Bundle.main.apiKey,
                        "movieCd": movieCode])
    }
    
    static func movieImage(query: String) -> APIConfig<MovieImageDTO> {
        return .init(baseURL: BoxOfficeAPI.imageBaseUrl,
                     path: BoxOfficeAPI.movieImage.path,
                     headerParameters: [
                        "Authorization": Bundle.main.kakaoApiKey], queryParameters: [
                            "query": "\(query) 영화 포스터"])
    }
}
