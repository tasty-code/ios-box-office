//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Roh on 2/24/24.
//

import Foundation

struct DailyBoxOffice: KobisAPI {
    var path: String
    var date: String
    
    init(
        path: String,
        date: String
    ) {
        self.path = path
        self.date = date
    }
}
 
