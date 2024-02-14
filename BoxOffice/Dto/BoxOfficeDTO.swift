import Foundation

struct BoxOfficeDTO: Decodable {
    private let boxOfficeType: String
    private let showRange: String
    private let movieBoxOfficeList: Array<MovieBoxOfficeDTO>
    
    init(boxOfficeType: String, showRange: String, movieBoxOfficeList: Array<MovieBoxOfficeDTO>) {
        self.boxOfficeType = boxOfficeType
        self.showRange = showRange
        self.movieBoxOfficeList = movieBoxOfficeList
    }
}

enum BoxofficeCodingKeys: String, CodingKey {
    case boxOfficeType = "boxofficeType"
    case showRange = "showRange"
    case movieBoxOfficeList = "dailyBoxOfficeList"
}
