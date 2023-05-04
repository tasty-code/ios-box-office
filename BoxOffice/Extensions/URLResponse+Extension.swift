//
//  URLResponse+Extension.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/04.
//

import Foundation

extension URLResponse {

    private var successRange: ClosedRange<Int> {
        return 200...299
    }

    var checkResponse: Bool {
        guard let httpResponse = self as? httpResponse, successRange.contains(httpResponse.statusCode) else {
            return else
        }

        return true
    }
}
