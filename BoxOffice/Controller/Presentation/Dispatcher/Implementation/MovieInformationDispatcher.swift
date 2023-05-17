//
//  MovieInformationDispatcher.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/16.
//

import UIKit

struct MovieInformationDispatcher: PresentationDispatchable {
    
    typealias ViewModel = MovieInformationItem
    typealias Endpoint = MovieInformationEndpoint
    
    func convert(from networkData: MovieInformationDTO) throws -> [MovieInformationItem] {
        
        let data = networkData.result.movieIformation
        let movieInformation = [ViewModel(movieName: data.movieName,
                                          directors: data.directors,
                                          productionYear: data.productionYear,
                                          openDate: data.openDate,
                                          showTime: data.showTime,
                                          audits: data.audits,
                                          nations: data.nations,
                                          genres: data.genres,
                                          actors: data.actors)]
        return movieInformation
    }
    
    func fetchMoviePosterDTO(_ endpoint: MoviePosterEndpoint) async throws -> MoviePosterEndpoint.Response {
        
        let networkResult = try await networkProvider.request(endpoint)
        
        switch networkResult {
        case .success(let decodingData):
            return decodingData
        case .failure(let error):
            throw error
        }
    }
    
    func convertImage(from networkData: MoviePosterDTO) throws -> UIImage? {
        
        let urlString = networkData.result.first?.imageURL ?? ""
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        urlComponents.scheme = "https"
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        let data = try Data(contentsOf: url)
        
        return UIImage(data: data)
    }
}
