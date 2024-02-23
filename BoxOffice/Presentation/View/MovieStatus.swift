enum MovieStatus {
  case newMovie
  case oldMovie(RiseOrFall)
  
  enum RiseOrFall {
    case risen(Int)
    case fallen(Int)
    case maintained
  }

  init(
    entryStatus: DailyBoxOffice.ListItem.EntryStatus,
    rankChange: DailyBoxOffice.ListItem.RankChange
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
