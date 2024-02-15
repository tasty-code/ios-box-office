// MARK: - SearchMovieInfo
struct SearchMovieInfo: Decodable {
  // MARK: - MovieInfoResult
  struct MovieInfoResult: Decodable {
    // MARK: - MovieInfo
    struct MovieInfo: Decodable {
      // MARK: - Nation
      struct Nation: Decodable {
        let nationName: String
        
        enum CodingKeys: String, CodingKey {
          case nationName = "nationNm"
        }
      }

      // MARK: - Genre
      struct Genre: Decodable {
        let genreName: String
        
        enum CodingKeys: String, CodingKey {
          case genreName = "genreNm"
        }
      }

      // MARK: - Director
      struct Director: Decodable {
        let name: String
        let englishName: String
        
        enum CodingKeys: String, CodingKey {
          case name = "peopleNm"
          case englishName = "peopleNmEn"
        }
      }

      // MARK: - Actor
      struct Actor: Decodable {
        let name: String
        let englishName: String
        let castingName: String
        let castingEnglishName: String
            
        enum CodingKeys: String, CodingKey {
          case name = "peopleNm"
          case englishName = "peopleNmEn"
          case castingName = "cast"
          case castingEnglishName = "castEn"
        }
      }

      // MARK: - ShowType
      struct ShowType: Decodable {
        let showTypeGroup: String
        let showTypeName: String
        
        enum CodingKeys: String, CodingKey {
          case showTypeGroup = "showTypeGroupNm"
          case showTypeName = "showTypeNm"
        }
      }

      // MARK: - Company
      struct Company: Decodable {
        let companyCode: String
        let companyName: String
        let companyEnglishName: String
        let companyParticipationType: String
        
        enum CodingKeys: String, CodingKey {
          case companyCode = "companyCd"
          case companyName = "companyNm"
          case companyEnglishName = "companyNmEn"
          case companyParticipationType = "companyPartNm"
        }
      }

      // MARK: - Audit
      struct Audit: Decodable {
        let auditCode: String
        let rating: String
        
        enum CodingKeys: String, CodingKey {
          case auditCode = "auditNo"
          case rating = "watchGradeNm"
        }
      }

      // MARK: - Staff
      struct Staff: Decodable {
        let name: String
        let englishName: String
        let staffRole: String
        
        enum CodingKeys: String, CodingKey {
          case name = "peopleNm"
          case englishName = "peopleNmEn"
          case staffRole = "staffRoleNm"
        }
      }
      
      let movieCode: String
      let movieKoreanName: String
      let movieEnglishName: String
      let movieOriginalName: String
      let runningTime: String
      let productionYear: String
      let releasedYear: String
      let productionStatus: String
      let movieType: String
      let nations: [Nation]
      let genres: [Genre]
      let directors: [Director]
      let actors: [Actor]
      let showTypes: [ShowType]
      let companys: [Company]
      let audits: [Audit]
      let staffs: [Staff]
      
      enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieKoreanName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case runningTime = "showTm"
        case productionYear = "prdtYear"
        case releasedYear = "openDt"
        case productionStatus = "prdtStatNm"
        case movieType = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
      }
    }

    let movieInfo: MovieInfo
    let source: String
  }

  let movieInfoResult: MovieInfoResult
}
