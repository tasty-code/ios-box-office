//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Roh on 2/17/24.
//

import Foundation

protocol KobisAPI {
    var url: String { get }
    var key: String { get }
}

extension KobisAPI {
    var url: String {
        "www.kobis.or.kr"
    }
    var key: String {
        "2c7b3f6025093cbb1df0f1e819bf8c65"
    }
}
