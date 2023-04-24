//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/04/24.
//

// MARK: - DailyBoxOffice
struct DailyBoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
    
    // MARK: - BoxOfficeResult
    struct BoxOfficeResult: Codable {
        let boxofficeType, showRange: String
        let dailyBoxOfficeList: [Movie]
    }
    
    // MARK: - Movie
    struct Movie: Codable {
        let rnum, rank, rankInten, rankOldAndNew, movieCD, movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt: String
        
        enum CodingKeys: String, CodingKey {
            case movieCD = "movieCd"
            case rnum, rank, rankInten, rankOldAndNew, movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
        }
    }
}
