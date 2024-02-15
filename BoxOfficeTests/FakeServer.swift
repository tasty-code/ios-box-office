//
//  FakeServer.swift
//  BoxOfficeTests
//
//  Created by LeeSeongYeon on 2024/02/15.
//

import Foundation
@testable import BoxOffice

class FakeServer {
    static let fakeURL_MovieDetailInfomation: String = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
    static let fakeURL_DailyBoxOffice: String = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
    
    class func data(from url: URL) throws -> Data? {
        let type: KoreanFilmCouncilURLEnumeration?
        if url.absoluteString.contains("searchDailyBoxOfficeList") {
            type = .dailyBoxOffice("", "")
        } else if url.absoluteString.contains("searchMovieInfo") {
            type = .movieDetailInfomation("", "")
        } else {
            throw HTTPStatusError.clientError
        }
        
        switch type {
        case .dailyBoxOffice("", ""):
            guard fakeURL_DailyBoxOffice == url.absoluteString else {
                throw HTTPStatusError.clientError
            }
            
            if Int.random(in: 1...10) == 1 {
                throw HTTPStatusError.serverError
            }
            
            guard let input = """
            {"boxOfficeResult":{"boxofficeType":"일별 박스오피스","showRange":"20220105~20220105","dailyBoxOfficeList":[{"rnum":"1","rank":"1","rankInten":"0","rankOldAndNew":"NEW","movieCd":"20199882","movieNm":"경관의 피","openDt":"2022-01-05","salesAmt":"584559330","salesShare":"34.2","salesInten":"584559330","salesChange":"100","salesAcc":"631402330","audiCnt":"64050","audiInten":"64050","audiChange":"100","audiAcc":"69228","scrnCnt":"1171","showCnt":"4416"}]}}
            """.data(using: .utf8) else { return nil }
            return input
        
        case .movieDetailInfomation("", ""):
            guard fakeURL_MovieDetailInfomation == url.absoluteString else {
                throw HTTPStatusError.clientError
            }
            
            if Int.random(in: 1...10) == 1 {
                throw HTTPStatusError.serverError
            }
            
            guard let input = """
            {"movieInfoResult":{"movieInfo":{"movieCd":"20124079","movieNm":"광해, 왕이 된 남자","movieNmEn":"Masquerade","movieNmOg":"","showTm":"131","prdtYear":"2012","openDt":"20120913","prdtStatNm":"개봉","typeNm":"장편","nations":[{"nationNm":"한국"}],"genres":[{"genreNm":"사극"},{"genreNm":"드라마"}],"directors":[{"peopleNm":"추창민","peopleNmEn":"CHOO Chang-min"}],"actors":[{"peopleNm":"이병헌","peopleNmEn":"LEE Byung-hun","cast":"광해/하선","castEn":""},{"peopleNm":"류승룡","peopleNmEn":"RYU Seung-ryong","cast":"허균","castEn":""}],"showTypes":[{"showTypeGroupNm":"필름","showTypeNm":"필름"}],"audits":[{"auditNo":"2012-F610","watchGradeNm":"15세이상관람가"}],"staffs":[{"peopleNm":"문성주","peopleNmEn":"MOON Sung-joo","staffRoleNm":"투자"}]},"source":"영화진흥위원회"}}
            """.data(using: .utf8) else { return nil }
            return input
        
        default:
            throw HTTPStatusError.clientError
        }
    }
}
