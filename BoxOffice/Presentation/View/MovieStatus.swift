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
  
  var text: String? {
    switch self {
    case .newMovie:
      return "신작"
    case .oldMovie(let riseOrFall):
      switch riseOrFall {
      case .risen(let number):
        return String(number)
      case .fallen(let number):
        return String(number)
      case .maintained:
        return "-"
      }
    }
  }
  
  var imageName: String? {
    switch self {
    case .newMovie:
      return nil
    case .oldMovie(let riseOrFall):
      switch riseOrFall {
      case .risen:
        return "arrowtriangle.up.fill"
      case .fallen:
        return "arrowtriangle.down.fill"
      case .maintained:
        return nil
      }
    }
  }
}
