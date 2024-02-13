//
//  BoxOfficeData.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/13/24.
//

import Foundation

final class BoxOffice: Decodable {
    private(set) var parsedData: BoxOfficeResult? = nil
    
    enum CodingKeys: String, CodingKey {
        case parsedData = "boxOfficeResult"
    }
    
    init() {
        self.parsedData = parseJSONData()
    }
    
    private func parseJSONData() -> BoxOfficeResult? {
        guard let fileLocation = Bundle.main.url(forResource: "box_office_sample", withExtension: "json") else {
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            let data = try decoder.decode(BoxOfficeResult.self, from: jsonData)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOfficeDetail
}

struct BoxOfficeDetail: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieData]
}

struct MovieData: Decodable {
    let index: String
    let rank: String
    let rankChangedAmount: String
    let rankStatus: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesChangedAmount: String
    let salesChangedPercentage: String
    let salesAccmulated: String
    let audienceCount: String
    let audienceChangedAmount: String
    let audienceChangedPercentage: String
    let audienceAccmulated: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case index = "rnum"
        case rank
        case rankChangedAmount = "rankInten"
        case rankStatus = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesChangedAmount = "salesInten"
        case salesChangedPercentage = "salesChange"
        case salesAccmulated = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChangedAmount = "audiInten"
        case audienceChangedPercentage = "audiChange"
        case audienceAccmulated = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
