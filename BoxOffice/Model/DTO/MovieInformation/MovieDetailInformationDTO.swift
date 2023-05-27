//
//  MovieDetailInformationDTO.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/01.
//

import UIKit

struct MovieDetailInformationDTO: Decodable, Convertable {
    let movieInfoResult: MovieInfoResultDTO

    enum CodingKeys: String, CodingKey {
        case movieInfoResult
    }
}

extension MovieDetailInformationDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movieInfoResult = try container.decode(MovieInfoResultDTO.self, forKey: .movieInfoResult)
    }
}

extension MovieDetailInformationDTO {
    func convert() -> MovieDatable {
        let movieInformation = movieInfoResult.movieInformation
        let productYear = movieInformation?.productYear ?? ""
        let openDate = movieInformation?.openDate ?? ""
        let showTime = movieInformation?.showTime ?? ""
        var directors = [String]()
        var genres = [String]()
        var actors = [String]()
        var nations = [String]()
        var audits = String()

        if let existedNations = movieInformation?.nations {
            nations = existedNations.compactMap { nation in
                nation.nationName
            }
        }
        if let existedGenres = movieInformation?.genres {
            genres = existedGenres.compactMap { genre in
                genre.genreName
            }
        }
        if let existedActor = movieInformation?.actors {
            actors = existedActor.compactMap { movieActor in
                movieActor.peopleName
            }
        }
        if let existedDirector = movieInformation?.directors {
            directors = existedDirector.compactMap { director in
                director.peopleName
            }
        }

        if let existedAudit = movieInformation?.audits {
            audits = existedAudit.first?.watchGradeName ?? ""
        }

        return MovieInformation(directors: directors,
                                productYear: productYear,
                                openDate: openDate,
                                showTime: showTime,
                                nations: nations,
                                genres: genres,
                                actors: actors,
                                audits: audits)
    }
}
