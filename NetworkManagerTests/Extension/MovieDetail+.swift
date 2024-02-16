//
//  MovieDetail+.swift
//  BoxOffice
//
//  Created by Lee minyeol on 2/17/24.
//

import Foundation

extension MovieInfo: Equatable {
    static func == (lhs: MovieInfo, rhs: MovieInfo) -> Bool {
        return lhs.movieCode == rhs.movieCode &&
        lhs.movieName == rhs.movieName &&
        lhs.movieEnglishName == rhs.movieEnglishName &&
        lhs.movieOriginalName == rhs.movieOriginalName &&
        lhs.movieCode == rhs.movieCode &&
        lhs.openDate == rhs.openDate &&
        lhs.showTime == rhs.showTime &&
        lhs.productYear == rhs.productYear &&
        lhs.openDate == rhs.openDate &&
        lhs.productStateName == rhs.productStateName &&
        lhs.typeName == rhs.typeName &&
        lhs.nations == rhs.nations &&
        lhs.genres == rhs.genres &&
        lhs.directors == rhs.directors &&
        lhs.actors == rhs.actors &&
        lhs.showTypes == rhs.showTypes &&
        lhs.companys == rhs.companys &&
        lhs.audits == rhs.audits &&
        lhs.staffs == rhs.staffs
    }
}

extension MovieInfoResult: Equatable {
     static func == (lhs: MovieInfoResult, rhs: MovieInfoResult) -> Bool {
         return lhs.movieInfo == rhs.movieInfo &&
         lhs.source == rhs.source
    }
}

extension MovieDetail: Equatable {
     static func == (lhs: MovieDetail, rhs: MovieDetail) -> Bool {
         return lhs.movieInfoResult == rhs.movieInfoResult
    }
}

extension Actor: Equatable {
    static func == (lhs: Actor, rhs: Actor) -> Bool {
        return lhs.peopleName == rhs.peopleName &&
        lhs.peopleEnglishName == rhs.peopleEnglishName &&
        lhs.cast == rhs.cast &&
        lhs.castEnglish == rhs.castEnglish
    }
}

extension Nation: Equatable {
    static func == (lhs: Nation, rhs: Nation) -> Bool {
        return lhs.nationName == rhs.nationName
    }
}

extension Staff: Equatable {
    static func == (lhs: Staff, rhs: Staff) -> Bool {
        return lhs.peopleName == rhs.peopleName &&
        lhs.peopleEnglishName == rhs.peopleEnglishName &&
        lhs.staffRoleName == rhs.staffRoleName
    }
}

extension ShowType: Equatable {
    static func == (lhs: ShowType, rhs: ShowType) -> Bool {
        return lhs.showTypeGroupName == rhs.showTypeGroupName &&
        lhs.showTypeName == rhs.showTypeName
    }
}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.genreName == rhs.genreName
    }
}

extension Director: Equatable {
    static func == (lhs: Director, rhs: Director) -> Bool {
        return lhs.peopleName == rhs.peopleName &&
        lhs.peopleEnglishName == rhs.peopleEnglishName
    }
}

extension Company: Equatable {
    static func == (lhs: Company, rhs: Company) -> Bool {
        return lhs.companyCode == rhs.companyCode &&
        lhs.companyName == rhs.companyName &&
        lhs.companyEnglishName == rhs.companyEnglishName &&
        lhs.companyPartName == rhs.companyPartName
    }
}

extension Audit: Equatable {
    static func == (lhs: Audit, rhs: Audit) -> Bool {
        return lhs.auditNumber == rhs.auditNumber &&
        lhs.watchGradeName == rhs.watchGradeName
    }
}
