//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/25.
//

import UIKit

struct BoxOfficeDTO: Decodable, Convertable {
    let boxOfficeResult: DailyBoxOfficeResultDTO

    enum CodingKeys: String, CodingKey {
        case boxOfficeResult
    }
}

extension BoxOfficeDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        boxOfficeResult = try container.decode(DailyBoxOfficeResultDTO.self, forKey: .boxOfficeResult)
    }
}

extension BoxOfficeDTO {
    func convert() -> MovieDatable {
        let date = formatter(date: boxOfficeResult.showRange)
        let movies = boxOfficeResult.dailyBoxOfficeList.map { movie in
            return movie.convert()
        }

        return DailyBoxOffice(date: date, movies: movies)
    }
}

private func formatter(date: String) -> Date {
    guard let splittedStringDate = date.components(separatedBy: "~").first else {
        return Date()
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"

    guard let date = dateFormatter.date(from: splittedStringDate) else {
        return Date()
    }

    return date
}
