//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by 박재우 on 2023/04/24.
//

import XCTest

final class BoxOfficeTests: XCTestCase {

    func test_json파일을_Data타입으로_제대로_하는지_확인() throws {
        if let path = Bundle.main.path(forResource: name, ofType: "json"),
           let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
            return jsonData
        }
        return nil
    }

    func test_데이터_변환을_제대로_하는지_확인() throws {
        do {
            guard let data = readLocalFile(forName: "BoxOfficeData") else {
                print("실패")
                return
            }
            let decodedData = try JSONDecoder().decode(MovieBoxOffice.self, from: data)
            print(decodedData)
        } catch {
            print(error)
        }
    }
}
