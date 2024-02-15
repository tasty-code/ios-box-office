//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by LeeSeongYeon on 2024/02/13.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: BoxOfficeDTO?
    
    override func setUpWithError() throws {
        sut = BoxOfficeDTO()
    }
    
    func test_json을_전달했을때_BoxOfficeResult_구조체로_파싱되었는가() {
        // given
        guard let input = """
        {"boxOfficeResult":{"boxofficeType":"일별 박스오피스","showRange":"20220105~20220105","dailyBoxOfficeList":[{"rnum":"1","rank":"1","rankInten":"0","rankOldAndNew":"NEW","movieCd":"20199882","movieNm":"경관의 피","openDt":"2022-01-05","salesAmt":"584559330","salesShare":"34.2","salesInten":"584559330","salesChange":"100","salesAcc":"631402330","audiCnt":"64050","audiInten":"64050","audiChange":"100","audiAcc":"69228","scrnCnt":"1171","showCnt":"4416"}]}}
        """.data(using: .utf8) else { return }
        let expectation = "경관의 피"
        
        // when
        guard let result: BoxOfficeResult = sut?.parseJSONData(input) else { return }
        
        // then
        XCTAssertEqual(result.boxOfficeResult.dailyBoxOfficeList.first?.movieName, expectation, "예상되는 값은 경관의 피")
    }
    
    func test_json을_파싱했을때_알맞은_타입으로_파싱되었는가() {
        // given
        guard let input = """
        {"boxOfficeResult":{"boxofficeType":"일별 박스오피스","showRange":"20220105~20220105","dailyBoxOfficeList":[{"rnum":"2","rank":"2","rankInten":"-1","rankOldAndNew":"OLD","movieCd":"20210028","movieNm":"스파이더맨: 노 웨이 홈","openDt":"2021-12-15","salesAmt":"507028380","salesShare":"29.6","salesInten":"-91443730","salesChange":"-15.3","salesAcc":"62772471900","audiCnt":"50399","audiInten":"-9564","audiChange":"-15.9","audiAcc":"6252827","scrnCnt":"1357","showCnt":"4314"}]}}
""".data(using: .utf8) else { return }
        let expectation = String.self
        
        // when
        guard let result: BoxOfficeResult = sut?.parseJSONData(input) else { return }
        
        // then
        XCTAssertTrue(type(of: result.boxOfficeResult.boxofficeType) == expectation, "예상되는 값은 true")
    }
}
