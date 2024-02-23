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

enum MovieStatus {
  case newMovie
  case oldMovie(RiseOrFall)
  
  enum RiseOrFall {
    case risen(Int)
    case fallen(Int)
    case maintained
  }

  init(
    entryStatus: DailyBoxOfficeResponse.DailyBoxOfficeItem.EntryStatus,
    rankChange: DailyBoxOfficeResponse.DailyBoxOfficeItem.RankChange
  ) {
    let riseOrFall: RiseOrFall
    switch rankChange {
    case .risen(let number):
      riseOrFall = .risen(number)
    case .fallen(let number):
      riseOrFall = .fallen(number)
    case .maintained:
      riseOrFall = .maintained
    }
    
    switch entryStatus {
    case .new:
      self = .newMovie
    case .old:
      self = .oldMovie(riseOrFall)
    }
  }
}
