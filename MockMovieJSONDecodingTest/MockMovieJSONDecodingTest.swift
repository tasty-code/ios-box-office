//
//  MockMovieJSONDecodingTest.swift
//  MockMovieJSONDecodingTest
//
//  Created by Jason on 2023/04/24.
//

import XCTest

final class MockMovieJSONDecodingTest: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Bundle의_경로가_Nil이_아닌지() {
        // given
        let bundle = Bundle(for: type(of: self))

        // then
        XCTAssertNotNil(bundle)
    }

    func test_filePath의_경로가_Nil이_아닌지() {
        // given
        let bundle = Bundle(for: type(of: self))

        // when
        let filePath = bundle.path(forResource: "Movie", ofType: "json")!

        // then
        XCTAssertNotNil(filePath)

    }

    func test_filePath를_통해_Mock데이터가_Nil이_아닌지() {
        // given
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "Movie", ofType: "json")!

        // when
        let jsonString = try? String(contentsOfFile: filePath)

        // then
        XCTAssertNotNil(jsonString)
    }

    func test_data가_있으며_Binary형태의_타입인지() {
        // given
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "Movie", ofType: "json")!
        let jsonString = try? String(contentsOfFile: filePath)

        // when
        let data = jsonString?.data(using: .utf8)

        // then
        XCTAssertNotNil(data)
    }

    func test_data가_디코딩_되었는지() {
        // given
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "Movie", ofType: "json")!
        let jsonString = try? String(contentsOfFile: filePath)
        guard let data = jsonString?.data(using: .utf8) else { return }

        // when
        let boxOffice = try? JSONDecoder().decode(BoxOffice.self, from: data)

        // then
        XCTAssertNotNil(boxOffice)
    }
}
