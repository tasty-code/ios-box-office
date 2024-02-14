import Foundation

struct BoxOfficeResultDTO: Decodable {
    private let boxOfficeResult: BoxOfficeDTO
}

extension BoxOfficeResultDTO {
    func boxOfficeDTO() -> BoxOfficeDTO {
        return boxOfficeResult
    }
}
