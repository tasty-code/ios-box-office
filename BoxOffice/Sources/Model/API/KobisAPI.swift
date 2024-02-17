//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Roh on 2/16/24.
//

import Foundation

enum KobisAPI {
    case dailyBoxOffice(url: String, key: String, date: String)
    case detailMovie(url: String, key: String, code: String)
}

extension KobisAPI {
    var interface: (url: String, key: String, value: String) {
        switch self {
        case .dailyBoxOffice(let url, let key, let date):
            return (url, key, date)
        case .detailMovie(let url, let key, let code):
            return (url, key, code)
        }
    }
}

