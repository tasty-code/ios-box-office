// swiftlint:disable nesting
struct SearchDailyBoxOfficeDTO: Decodable {
  struct Result: Decodable {
    struct BoxOfficeItem: Decodable {
      enum EntryStatus: String, Codable {
        case new = "NEW"
        case old = "OLD"
      }
      
      let index: String
      let rank: String
      let rankChange: String
      let entryStatus: EntryStatus
      let movieCode: String
      let movieName: String
      let releaseDate: String
      let salesAmount: String
      let salesShare: String
      let salesChange: String
      let salesChangeRate: String
      let salesTotal: String
      let audienceCount: String
      let audienceChange: String
      let audienceChangeRate: String
      let audienceTotal: String
      let screenCount: String
      let showCount: String
      
      enum CodingKeys: String, CodingKey {
        case index = "rnum"
        case rank
        case rankChange = "rankInten"
        case entryStatus = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case releaseDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesChange = "salesInten"
        case salesChangeRate = "salesChange"
        case salesTotal = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChange = "audiInten"
        case audienceChangeRate = "audiChange"
        case audienceTotal = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
      }
    }
    
    let boxOfficeType: String
    let showRange: String
    let list: [BoxOfficeItem]
    
    enum CodingKeys: String, CodingKey {
      case boxOfficeType = "boxofficeType"
      case showRange
      case list = "dailyBoxOfficeList"
    }
  }
  
  let boxOfficeResult: Result
}
// swiftlint:enable nesting

extension SearchDailyBoxOfficeDTO.Result.BoxOfficeItem.EntryStatus: DomainConvertible {
  typealias Domain = DailyBoxOffice.ListItem.EntryStatus
  
  func toDomain() throws -> DailyBoxOffice.ListItem.EntryStatus {
    switch self {
    case .new: return .new
    case .old: return .old
    }
  }
}

extension SearchDailyBoxOfficeDTO.Result.BoxOfficeItem: DomainConvertible {
  typealias Domain = DailyBoxOffice.ListItem
  
  func toDomain() throws -> DailyBoxOffice.ListItem {
    guard
      let rank = Int(self.rank),
      let rankChange = Int(self.rankChange),
      let today = Int(self.audienceCount),
      let total = Int(self.audienceTotal)
    else {
      throw DTOError.cannotConvertToDomain
    }
    return .init(
      index: self.index,
      rank: rank,
      rankChange: .init(value: rankChange),
      title: self.movieName,
      todayAudienceCount: today,
      totalAudienceCount: total,
      entryStatus: try self.entryStatus.toDomain()
    )
  }
}

import Foundation

extension SearchDailyBoxOfficeDTO.Result: DomainConvertible {
  typealias Domain = DailyBoxOffice
  
  func toDomain() throws -> DailyBoxOffice {
    return .init(
      date: try parseDate(self.showRange),
      list: self.list.compactMap { item in try? item.toDomain() }
    )
  }
  
  private func parseDate(_ dateRange: String) throws -> Date {
    let rangeString = self.showRange
    let tildeCharacter: Character = "~"
    let dateString = String(rangeString.prefix(while: { $0 != tildeCharacter }))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    if let date = dateFormatter.date(from: dateString) {
      return date
    } else {
      throw DTOError.cannotConvertToDomain
    }
  }
}

enum DTOError: Error {
  case cannotConvertToDomain
}
