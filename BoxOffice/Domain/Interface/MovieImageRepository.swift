import Foundation

protocol MovieImageRepository {
    func fetchMovieImage(for query: String, completion: @escaping (Result<MovieImage, Error>) -> Void) -> URLSessionTask?
}
