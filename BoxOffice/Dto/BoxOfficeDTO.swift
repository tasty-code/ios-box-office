import Foundation

struct BoxOfficeDTO: Decodable {
    private let boxofficeType: String
    private let showRange: String
    private let movieBoxOfficeList: Array<MovieBoxOfficeDTO>
    
    init(boxofficeType: String, showRange: String, movieBoxOfficeList: Array<MovieBoxOfficeDTO>) {
        self.boxofficeType = boxofficeType
        self.showRange = showRange
        self.movieBoxOfficeList = movieBoxOfficeList
    }
}
