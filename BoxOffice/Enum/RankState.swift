import Foundation

enum RankState: String {
    case new
    case old
    
   private func getRankStateRawValue() -> String {
        switch self {
        case .new:
            return "NEW"
        case .old:
            return "OLD"
        }
    }
}
