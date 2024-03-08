//
//  Errors.swift
//  BoxOffice
//
//  Created by dopamint on 2/13/24.
//

enum NetworkError: Error {
    
    case netWorkingError
    case parseError
    case dataError
    
    func description() {
        switch self {
        case .netWorkingError:
            print("네트워크 에러")
        case .parseError:
            print("파싱 에러")
        case .dataError:
            print("데이터 에러")
        }
    }
}
