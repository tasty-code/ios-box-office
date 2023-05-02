//
//  NetworkConfigurable.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/02.
//

import Foundation

protocol NetworkConfigurable {
    
    var baseURL: URL { get }
    var queryParameters: [String: String] { get }
    
}
