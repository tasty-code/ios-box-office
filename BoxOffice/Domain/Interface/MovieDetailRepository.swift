import Foundation

protocol MovieDetailRepository {
    func fetchBoxOfficeList(movieCode: String, completion: @escaping (Result<Movie, Error>) -> Void) -> URLSessionTask?
}
