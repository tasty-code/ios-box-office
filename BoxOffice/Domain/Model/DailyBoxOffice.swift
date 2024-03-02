import Foundation

struct DailyBoxOffice {
  let date: Date
  let list: [ListItem]
  
  struct ListItem: Hashable {
    let index: String
    let rank: Int
    let rankChange: RankChange
    let title: String
    let todayAudienceCount: Int
    let totalAudienceCount: Int
    let entryStatus: EntryStatus
    
    enum EntryStatus: String, Hashable {
      case new = "NEW"
      case old = "OLD"
    }
    
    enum RankChange: Hashable {
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
