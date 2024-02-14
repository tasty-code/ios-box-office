
enum JsonParsingError: Error {
    case pathError
    case dataLoadError
    case decodingError
    case fileLoadError
    
    var errorMessage: String {
        switch self {
        case .pathError:
            "파일의 경로를 읽어오지 못했습니다."
        case .dataLoadError:
            "데이터를 불러오지 못했습니다."
        case .decodingError:
            "파일 디코딩에 실패했습니다."
        case .fileLoadError:
            "파일을 불러오는 것에 실패했습니다."
        }
    }
}
