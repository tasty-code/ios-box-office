//
//  MovieInformationItem.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/16.
//

import UIKit

struct MovieInformationItem: ViewDisplayable {

    let movieName: String
    var poster: UIImage?
    let director: String
    let productionYear: String
    let openDate: String
    let showTime: String
    let auditGrade: String
    let nation: String
    let genre: String
    let actor: String

    init(movieName: String, poster: UIImage? = nil, directors: [DirectorDTO], productionYear: String, openDate: String, showTime: String, audits: [AuditDTO], nations: [NationDTO], genres: [GenreDTO], actors: [ActorDTO]) {

        self.movieName = movieName
        self.poster = poster
        self.productionYear = productionYear
        self.openDate = openDate
        self.showTime = showTime

        let director = directors.first?.peopleNm ?? ""
        self.director = director

        let auditGrade = audits.first?.watchGradeNm ?? ""
        self.auditGrade = auditGrade

        let nation = nations.first?.nationNm ?? ""
        self.nation = nation

        let genre = genres.map { $0.genreNm }.joined(separator: ", ")
        self.genre = genre

        let actor = actors.map { $0.peopleNm }.joined(separator: ", ")
        self.actor = actor
    }
}
