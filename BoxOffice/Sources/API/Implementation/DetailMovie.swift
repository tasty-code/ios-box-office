//
//  DetailMovie.swift
//  BoxOffice
//
//  Created by Roh on 2/24/24.
//

import Foundation

struct DetailMovie: KobisAPI {
    var path: String
    var code: String
    
    init(
        path: String,
        code: String
    ) {
        self.code = code
        self.path = path
    }
}
