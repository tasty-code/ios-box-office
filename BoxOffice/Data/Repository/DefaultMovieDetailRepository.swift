import Foundation

final class DefaultMovieDetailRepository {
    private let dataTransferService: DefaultDataTransferService
    
    init(dataTransferService: DefaultDataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMovieDetailRepository: MovieDetailRepository {
    func fetchBoxOfficeList(movieCode: String, completion: @escaping (Result<Movie, Error>) -> Void) -> URLSessionTask? {
        return dataTransferService.request(with: API.movieAPI(with: movieCode)) { result in
            switch result {
            case .success(let movieDetailResponseDTO):
                completion(.success(movieDetailResponseDTO.movieInfoResult.movieInfo.toModel()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
    
