//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//

import XCTest
@testable import BoxOffice

final class BoxOfficeJsonDataTests: XCTestCase {
    var parsedData: Data = Data()
    var decodedData: BoxOfficeData?
    
    enum JsonError: LocalizedError {
        case jsonLoadFail
        case jsonDecodedFail
        var errorDescription: String? {
            switch self {
            case .jsonLoadFail:
                return "json 로드 에러"
            case .jsonDecodedFail:
                return "json 디코드 에러"
            }
        }
    }
    
    //파싱하는 함수 생성
    func paserJson(forResource: String) throws -> BoxOfficeData {
        guard let path = Bundle.main.url(forResource: forResource, withExtension: "json"),
              let data = try? Data(contentsOf: path) else { throw JsonError.jsonLoadFail }
        parsedData = data
        guard let decodedData = try? JSONDecoder().decode(BoxOfficeData.self, from: parsedData) else { throw JsonError.jsonDecodedFail }
        
        return decodedData
    }
    
    func test_box_office_json파일을_로드_디코딩_성공하면_데이터값이_nil이_아니다() {
        // given
        let jsonName = "box_office"
        // when
        let sut = Result { try paserJson(forResource: jsonName)}
        
        switch sut {
        case .success(let data):
            decodedData = data
        case .failure(let error):
            print("jsonEror: \(error.localizedDescription)")
            decodedData = nil
        }
        // then
        XCTAssertNotNil(decodedData,"json 데이터 로드or디코딩 실패")
    }
    
    func test_json_파일_경로가_잘못되면_데이터_값이_nil이다() {
        // given
        let jsonName = "잘못된 json파일 이름"
        // when
        let sut = Result { try paserJson(forResource: jsonName)}
        
        switch sut {
        case .success(let data):
            decodedData = data
        case .failure(let error):
            print(error.localizedDescription)
            decodedData = nil
        }
        // then
        XCTAssertNil(decodedData,"json 데이터 로드 또는 디코딩이 실패")
    }
    
    func test_json_파일_경로가_잘못되면_로드실패_jsonLoadFaill_에러가_발생한다() {
        // given
        let jsonName = "잘못된 json파일 이름"
        var jsonError: Error?
        // when
        let sut = Result { try paserJson(forResource: jsonName)}
        
        switch sut {
        case .success(let data):
            decodedData = data
        case .failure(let error):
            print(error.localizedDescription)
            jsonError = error
            decodedData = nil
        }
        // then
        XCTAssertEqual(jsonError as! BoxOfficeJsonDataTests.JsonError, JsonError.jsonLoadFail, "에러타입이 다르다")
    }
    
    func test_파싱한데이터의_리스트가_10개여야_한다() {
        // given
        let jsonName = "box_office"
        var decodedData: BoxOfficeData?
        var error: Error?

        // when
        do {
            decodedData = try paserJson(forResource: jsonName)
        } catch let parseError {
            error = parseError
        }

        // then
        XCTAssertNil(error, "JSON 파싱 중 오류가 발생했습니다: \(error?.localizedDescription ?? "")")
        XCTAssertEqual(decodedData?.boxOfficeResult.dailyBoxOfficeList.count, 10, "가져온 데이터의 리스트 개수가 10개가 아닙니다.")
    }
}
