import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: JSONLoader!

    override func setUpWithError() throws {
        sut = JSONLoader()
    }
    
    func test제이슨파일에서데이터가져오기성공() {
           let testBundle = Bundle(for: type(of: self))

        guard let movie: BoxOffice = try? sut.loadJSON(from: testBundle, fileName: "box_office_sample") else {
               XCTFail("데이터 로딩 실패")
               return
           }
           let expectedCount: Int = 10
           XCTAssertNotNil(movie, "JSON 파일에서 데이터를 정상적으로 가져오지 못했습니다.")
        XCTAssertEqual(movie.boxOfficeResult.dailyBoxOfficeList.count, expectedCount, "항목 갯수 불일치")
       }
}
