import Foundation

protocol MovieDetailUseCase {
    @discardableResult
    func fetch(movieCode: String, completion: @escaping (Result<Movie, Error>) -> Void) -> URLSessionTask?
}

final class DefaultMovieDetailUseCase: MovieDetailUseCase {
    private let movieDetailRepository: MovieDetailRepository
    
    init(movieDetailRepository: MovieDetailRepository) {
        self.movieDetailRepository = movieDetailRepository
    }
    
    func fetch(movieCode: String, completion: @escaping (Result<Movie, Error>) -> Void) -> URLSessionTask? {
        return movieDetailRepository.fetchBoxOfficeList(movieCode: movieCode) { result in
            completion(result)
        }
    }
}
