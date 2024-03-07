import Foundation

protocol BoxOfficeUseCase {
    @discardableResult
    func fetch(completion: @escaping (Result<BoxOffice, Error>) -> Void) -> URLSessionTask?
}

final class DefaulBoxOfficeUseCase: BoxOfficeUseCase {
    private let boxOfficeRepository: BoxOfficeRepository
    
    init(boxOfficeRepository: BoxOfficeRepository) {
        self.boxOfficeRepository = boxOfficeRepository
    }
    
    func fetch(completion: @escaping (Result<BoxOffice, Error>) -> Void) -> URLSessionTask? {
        return boxOfficeRepository.fetchBoxOfficeList { result in
            completion(result)
        }
    }
}
