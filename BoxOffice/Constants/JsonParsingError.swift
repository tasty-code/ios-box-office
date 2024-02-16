
enum JsonParsingError: Error {
    case pathError
    case dataLoadError
    case decodingError
    
    var errorMessage: String {
        switch self {
        case .pathError:
            "파일의 경로를 읽어오지 못했습니다."
        case .dataLoadError:
            "데이터를 불러오지 못했습니다."
        case .decodingError:
            "파일 디코딩에 실패했습니다."
        }
    }
}
