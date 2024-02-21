//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 박찬호 on 2/20/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = ""
    private let session = URLSession(configuration: .default)
    
    private init() {}
    
    // 일일 박스오피스 조회
    func fetchDailyBoxOffice() {
        
    }
    
    // 영화 상세 조회
    func fetchMovieDetail() {
        
    }
    
    
    
}
