//
//  Movie.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/04/26.
//

struct Movie: Codable {
    
    let rank, rankInten, rankOldAndNew, code, name, openDate, salesAmount, salesShare, salesInten, salesChange, salesAcc, audienceCount, audienceInten, audienceChange, audienceAcc, screenCount, showCount: String
    
    enum CodingKeys: String, CodingKey {
        case code = "movieCd"
        case name = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case audienceCount = "audiCnt"
        case audienceInten = "audiInten"
        case audienceChange = "audiChange"
        case audienceAcc = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
        case rank, rankInten, rankOldAndNew, salesShare, salesInten, salesChange, salesAcc
    }
    
}
