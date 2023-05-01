//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/25.
//

import UIKit

struct BoxOfficeDTO: Decodable, Convertable {
    typealias MetaType = BoxOfficeDTO
    let boxOfficeResult: DailyBoxOfficeResultDTO
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

private func formatter(date: String) -> String {
    guard let date = date.components(separatedBy: "~").first else {
        return ""
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"

    guard let convertDate = dateFormatter.date(from: date) else {
        return ""
    }

    let newDateFormatter = DateFormatter()
    newDateFormatter.dateFormat = "yyyy년 MM월 dd일"

    return newDateFormatter.string(from: convertDate)
}
