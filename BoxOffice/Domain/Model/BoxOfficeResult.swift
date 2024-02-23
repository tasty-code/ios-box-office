//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Doyoung An on 2/17/24.
//

struct BoxOfficeResult {
    let boxOfficeType: BoxOfficeType
    let period: String
    let boxOfficeList: Array<BoxOffice>
}

enum BoxOfficeType {
    case daily, weekday, weekend
    
    init?(boxOfficeType: String) {
        switch boxOfficeType {
        case "일별 박스오피스":
            self = BoxOfficeType.daily
        case "주간 박스오피스":
            self = BoxOfficeType.weekday
        case "주말 박스오피스":
            self = BoxOfficeType.weekend
        default:
            print("Error: BoxOfficeType value unknown")
            return nil
        }
    }
    
    func boxOfficeType() -> String {
        switch self {
        case BoxOfficeType.daily:
            return "일별 박스오피스"
        case BoxOfficeType.weekday:
            return "주간 박스오피스"
        case BoxOfficeType.weekend:
            return "주말 박스오피스"
        }
    }
}

struct BoxOffice {
    let sequenceNumber: Int  // 순번을 출력합니다.
    let rankOfBoxOffice: Int  // 해당일자의 박스오피스 순위를 출력합니다.
    let rankChange: Int  // 전일대비 순위의 증감분을 출력합니다.
    let rankingNewcomer: RankingNewcomer  // 랭킹에 신규진입여부를 출력합니다. “OLD” : 기존 , “NEW” : 신규
    let movieCode: String  // 영화의 대표코드를 출력합니다.
    let movieName: String  // 영화명(국문)을 출력합니다.
    let releaseDate: String  // 영화의 개봉일을 출력합니다.
    let salesAmount: Int  // 해당일의 매출액을 출력합니다.
    let salesShareRatio: Double  // 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율을 출력합니다.
    let accumulatedSales: Int  // 누적매출액을 출력합니다.
    let audienceCount: Int  // 해당일의 관객수를 출력합니다.
    let audienceIncrease: Int  // 전일 대비 관객수 증감분을 출력합니다.
    let audienceChangeRatio: Double  // 전일 대비 관객수 증감 비율을 출력합니다.
    let accumulatedAudience: Int  // 누적관객수를 출력합니다.
    let numberOfScreens: Int // 해당일자에 상영한 스크린수를 출력합니다.
    let numberOfScreenings: Int // 해당일자에 상영된 횟수를 출력합니다.
}

enum RankingNewcomer {
    case new, old
    
    init?(rankingNewcomer: String) {
        switch rankingNewcomer {
        case "NEW":
            self = RankingNewcomer.new
        case "OLD":
            self = RankingNewcomer.old
        default:
            print("Error: RankingNewcomer value unknown")
            return nil
        }
    }
    
    func rankingNewcomer() -> String {
        switch self {
        case RankingNewcomer.new:
            return "신규"
        case RankingNewcomer.old:
            return "기존"
        }
    }
}
