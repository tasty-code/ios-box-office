//
//  MovieDetailInformationDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct MovieDetailInformationDTO {
    let movieInfoResult: MovieInfoResultDTO
}

extension MovieDetailInformationDTO {
    func convert() -> MovieInformation {
        let movieInformation = movieInfoResult.movieInformation
        let directors = movieInformation.directors.map { director in
            director.peopleName
        }
        let productYear = movieInformation.productYear
        let openDate = movieInformation.openDate
        let showTime = movieInformation.showTime
        let nations = movieInformation.nations.map { nation in
            nation.nationName
        }
        let genres = movieInformation.genres.map { genre in
            genre.genreName
        }

        var actors = [String]()
        if let existedActors = movieInformation.actors {
            actors = existedActors.map { actor in
                actor.peopleName
            }
        }

        return MovieInformation(directors: directors,
                                productYear: productYear,
                                openDate: openDate,
                                showTime: showTime,
                                nations: nations,
                                genres: genres,
                                actors: actors)
    }
}
