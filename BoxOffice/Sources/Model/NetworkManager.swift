//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Roh on 2/20/24.
//

import Foundation

struct NetworkManager {
    let successRange: Range = (200..<300)
    let redirectRange: Range = (300..<400)
    let clientErrorRange: Range = (400..<500)
    let serverErrorRange: Range = (500..<600)
    
    private init(
        networkSession: NetworkSessionProtocol,
        kobisAPI: KobisAPIProtocol
    ) {
        
    }
    
    func request() {
        //
    }
}
