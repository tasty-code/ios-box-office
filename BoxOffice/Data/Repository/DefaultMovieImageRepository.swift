import Foundation

final class DefaultMovieImageRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMovieImageRepository: MovieImageRepository {
    func fetchMovieImage(for query: String, completion: @escaping (Result<MovieImage, Error>) -> Void) -> URLSessionTask? {
        return dataTransferService.request(with: API.movieImage(query: query)) { result in
            switch result {
            case .success(let movieImageResponseDTO):
                completion(.success(movieImageResponseDTO.toModel()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
