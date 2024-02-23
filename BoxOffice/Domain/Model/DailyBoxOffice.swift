import Foundation

// TODO: 네이밍 재고
struct DailyBoxOfficeResponse {
  let date: Date
  let list: [DailyBoxOfficeItem]
  
  struct DailyBoxOfficeItem {
    let rank: Int
    let rankChange: RankChange
    let title: String
    let todayAudienceCount: Int
    let totalAudienceCount: Int
    let entryStatus: EntryStatus
    
    struct EntryStatus: RawRepresentable {
      static let new = Self(rawValue: "NEW")
      static let old = Self(rawValue: "OLD")
      
      let rawValue: String
    }
    
    enum RankChange {
      case risen(Int)
      case fallen(Int)
      case maintained
      
      init(value: Int) {
        if value > 0 {
          self = .risen(value)
        } else if value < 0 {
          self = .fallen(abs(value))
        } else {
          self = .maintained
        }
      }
    }
  }
}
