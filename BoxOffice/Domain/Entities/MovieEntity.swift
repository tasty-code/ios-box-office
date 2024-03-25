//
//  MovieEntity.swift
//  BoxOffice
//
//  Created by EUNJU on 3/13/24.
//

struct MovieEntity {
    let movieName: String
    let director: String
    let productYear: String
    let openDate: String
    let showTime: String
    let watchGrade: String
    let nation: String
    let genres: String
    let actors: String
    
    func getInfoArray() -> [(title: String, info: String)] {
        return [
            ("감독:", director),
            ("제작년도:", productYear),
            ("개봉일:", openDate),
            ("상영시간:", showTime),
            ("관람등급:", watchGrade),
            ("제작국가:", nation),
            ("장르:", genres),
            ("배우:", actors)
        ]
    }
}
