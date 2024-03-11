import Foundation

protocol MovieImageUseCase {
    @discardableResult
    func fetchMovieImage(movieName: String, completion: @escaping (Result<MovieImage, Error>) -> Void) -> URLSessionTask?
}

final class DefaulMovieImageUseCase: MovieImageUseCase {
    private let movieImageRepository: MovieImageRepository
    
    init(movieImageRepository: MovieImageRepository) {
        self.movieImageRepository = movieImageRepository
    }
    
    func fetchMovieImage(movieName: String, completion: @escaping (Result<MovieImage, Error>) -> Void) -> URLSessionTask? {
        return movieImageRepository.fetchMovieImage(for: movieName, completion: completion)
    }
}
