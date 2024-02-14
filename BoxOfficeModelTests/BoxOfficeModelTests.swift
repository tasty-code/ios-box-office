import XCTest

@testable import BoxOffice

final class BoxOfficeModelTests: XCTestCase {

    var sut: JsonLoader!
    
    override func setUpWithError() throws {
        sut = JsonLoader()
    }

    func test_박스오피스_json을_읽어서_BoxOfficeDTO로_파싱할_수_있다() {
        // given
        let expectation: MovieBoxOfficeDTO = MovieBoxOfficeDTO(
                                                rank: "1",
                                                rankChangesWithPreviousDay: "0",
                                                rankOldAndNew: "NEW",
                                                movieCode: "20199882",
                                                movieName: "경관의 피",
                                                openingDate: "2022-01-05",
                                                salesAmount: "584559330",
                                                salesShare: "34.2",
                                                salesChangesWithPreviousDay: "584559330",
                                                salesChangesRatioWithPreviousDay: "100",
                                                salesAccumulation: "631402330",
                                                audienceCount: "64050",
                                                audienceCountChangesWithPreviousDay: "64050",
                                                audienceCountChangesRatioWithPreviousDay: "100",
                                                audienceAccumulation: "69228",
                                                screenCount: "1171",
                                                showingCount: "4416")
        // when
        let result = sut.loadjson()?.boxOfficeDTO().boxOfficeList()[0]
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_파싱된_DTO를_Model로_변환시킬_수_있다() {
        // given
        let expectation: MovieBoxOffice = MovieBoxOffice(
                                                rank: 1,
                                                rankChangesWithPreviousDay: 0,
                                                rankOldAndNew: .new,
                                                movieCode: "20199882",
                                                movieName: "경관의 피",
                                                openingDate: "2022-01-05".toDate()!,
                                                salesAmount: 584559330,
                                                salesShare: 34.2,
                                                salesChangesWithPreviousDay: 584559330,
                                                salesChangesRatioWithPreviousDay: 100,
                                                salesAccumulation: 631402330,
                                                audienceCount: 64050,
                                                audienceCountChangesWithPreviousDay: 64050,
                                                audienceCountChangesRatioWithPreviousDay: 100,
                                                audienceAccumulation: 69228,
                                                screenCount: 1171,
                                                showingCount: 4416)
        // when
        let result = sut.loadjson()?.boxOfficeDTO().boxOfficeList()[0].toMovieBoxOffice()
        // then
        XCTAssertEqual(expectation, result)
    }

}
