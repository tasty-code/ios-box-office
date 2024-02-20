import XCTest
import Foundation

@testable import BoxOffice

final class BoxOfficeModelTests: XCTestCase {

    var sut: Data!
    override func setUpWithError() throws {
        sut = JsonLoader.loadjson(fileName: "box_office_sample")!
    }

    func test_박스오피스_json_BoxOfficeResponseDTO로_파싱할_수_있다() throws {
        // given
        let expectation = "일별 박스오피스"
        let decoder = JSONDecoder()
        // when
        let result = try decoder.decode(BoxOfficeResponseDTO.self, from: sut).boxOfficeResult.boxOfficeType
        // then
        XCTAssertEqual(expectation, result)
    }
}
