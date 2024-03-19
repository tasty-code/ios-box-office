//
//  APIType.swift
//  BoxOffice
//
//  Created by 강창현 on 3/19/24.
//

enum APIType {
    case boxOffice
    case kakao
    
    var host: String {
        switch self {
        case .boxOffice:
            return "www.kobis.or.kr"
        case .kakao:
            return "dapi.kakao.com"
        }
    }
}
