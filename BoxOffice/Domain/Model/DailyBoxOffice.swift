import Foundation

// TODO: 네이밍 재고
struct DailyBoxOffice {
  let date: Date
  let list: [ListItem]
  
  struct ListItem: Hashable {
    static func == (
      lhs: DailyBoxOffice.ListItem,
      rhs: DailyBoxOffice.ListItem
    ) -> Bool {
      return lhs.index == rhs.index && lhs.rank == rhs.rank
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(index)
      hasher.combine(rank)
    }
    
    let index: String
    let rank: Int
    let rankChange: RankChange
    let title: String
    let todayAudienceCount: Int
    let totalAudienceCount: Int
    let entryStatus: EntryStatus
    
    enum EntryStatus: String {
      case new = "NEW"
      case old = "OLD"
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
