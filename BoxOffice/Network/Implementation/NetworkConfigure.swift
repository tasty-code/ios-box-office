//
//  NetworkConfigure.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/02.
//

import Foundation

struct NetworkConfigure: NetworkConfigurable {
    
    var baseURL: URL
    var queryParameters: [String: String]
    
}
