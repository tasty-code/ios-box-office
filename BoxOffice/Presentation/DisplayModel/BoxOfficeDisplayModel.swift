
import Foundation

enum Section {
    case main
}

struct BoxOfficeDisplayModel: Hashable {
    let id: UUID = UUID()
    let rank: String
    let rankIntensity: String
    let isNew: Bool
    let movieName: String
    let audienceCount: String
    let audienceAccount: String
}

extension BoxOfficeDisplayModel {
    static var placeholder: BoxOfficeDisplayModel {
        return BoxOfficeDisplayModel(rank: "", rankIntensity: "0", isNew: false, movieName: "Loading...", audienceCount: "", audienceAccount: "")
    }
}
