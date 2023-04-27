//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Jason on 2023/04/27.
//

import Foundation

class NetworkService {
    
    private let session: URLSession
    private let endPoint: EndPoint
    
    init(session: URLSession = URLSession(configuration: .default), endPoint: EndPoint) {
        self.session = session
        self .endPoint = endPoint
    }
    
}
