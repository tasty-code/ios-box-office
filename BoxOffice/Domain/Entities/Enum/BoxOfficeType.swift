enum BoxOfficeType: String {
    case daily = "일별 박스오피스"
    case weekday = "주간 박스오피스"
    case weekend = "주말 박스오피스"
    case defaultType
}

extension BoxOfficeType {
    init(boxofficeType: String) {
        switch boxofficeType {
        case BoxOfficeType.daily.rawValue:
            self = .daily
        case BoxOfficeType.weekday.rawValue:
            self = .weekday
        case BoxOfficeType.weekend.rawValue:
            self = .weekend
        default:
            self = .defaultType
        }
    }
}
