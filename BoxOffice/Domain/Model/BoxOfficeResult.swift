//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Doyoung An on 2/17/24.
//

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let period: String
    let boxOfficeList: [BoxOfficeList]
}

struct BoxOfficeList: Codable {
    let sequenceNumber: String  // 순번을 출력합니다.
    let rankOfBoxOffice: String  // 해당일자의 박스오피스 순위를 출력합니다.
    let rankChange: String  // 전일대비 순위의 증감분을 출력합니다.
    let rankingNewcomer: String  // 랭킹에 신규진입여부를 출력합니다. “OLD” : 기존 , “NEW” : 신규
    let movieCode: String  // 영화의 대표코드를 출력합니다.
    let movieName: String  // 영화명(국문)을 출력합니다.
    let releaseDate: String  // 영화의 개봉일을 출력합니다.
    let salesAmount: String  // 해당일의 매출액을 출력합니다.
    let salesShareRatio: String  // 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율을 출력합니다.
    let accumulatedSales: String  // 누적매출액을 출력합니다.
    let audienceCount: String  // 해당일의 관객수를 출력합니다.
    let audienceIncrease: String  // 전일 대비 관객수 증감분을 출력합니다.
    let audienceChangeRatio: String  // 전일 대비 관객수 증감 비율을 출력합니다.
    let accumulatedAudience: String  // 누적관객수를 출력합니다.
    let numberOfScreens: String // 해당일자에 상영한 스크린수를 출력합니다.
    let numberOfScreenings: String // 해당일자에 상영된 횟수를 출력합니다.
}
