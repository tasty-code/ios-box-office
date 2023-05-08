//
//  DailyBoxOfficeAPI.swift
//  BoxOffice
//
//  Created by J.E on 2023/05/08.
//

import Foundation

struct DailyBoxOfficeEndPoint: EndPointProtocol {
    
    typealias DTO = DailyBoxOfficeDTO
    
    var baseURL: URL? {
        return URL(string: "https://kobis.or.kr/")
    }
    
    var method: HTTPMethodType {
        return .get
    }
    
    var path: String {
        return "kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    }
    
    var queryParameters: [String: String]
    
    init(date: String) {
        self.queryParameters = ["key": "f5eef3421c602c6cb7ea224104795888", "targetDt": date]
    }
    
}
