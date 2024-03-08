
import Foundation

enum Section {
    case main
}

struct BoxOfficeDisplayModel: Hashable {
    var id: UUID = UUID()
    var rank: String
    var rankIntensity: String
    let isNew: Bool
    var movieName: String
    let audienceCount: String
    var audienceAccount: String
}
