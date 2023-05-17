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

        let director = directors.first?.peopleName ?? ""
        self.director = director

        let auditGrade = audits.first?.watchGrade ?? ""
        self.auditGrade = auditGrade

        let nation = nations.first?.nationName ?? ""
        self.nation = nation

        let genre = genres.map { $0.genreName }.joined(separator: ", ")
        self.genre = genre

        let actor = actors.map { $0.peopleName }.joined(separator: ", ")
        self.actor = actor
    }
}
