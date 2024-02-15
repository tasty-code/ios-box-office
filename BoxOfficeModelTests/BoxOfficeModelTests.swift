import XCTest

@testable import BoxOffice

final class BoxOfficeModelTests: XCTestCase {

    var sut: JsonLoader!
    
    override func setUpWithError() throws {
        sut = JsonLoader()
    }

    func test_박스오피스_json을_읽어서_BoxOfficeResponseDTO로_파싱할_수_있다() {
        // given
        let expectation = "일별 박스오피스"
        // when
        let result = sut.loadjson()?.boxOfficeResult.boxOfficeType
        // then
        XCTAssertEqual(expectation, result)
    }
}

