import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
}

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    func request<T: Decodable, E: HTTPInteractable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? where E.Response == T
    
    func request<E: HTTPInteractable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<Void>
    ) -> URLSessionTask? where E.Response == Void
}

final class DefaultDataTransferService {
    
    private let networkService: NetworkService
    
    init(with networkService: NetworkService
    ) {
        self.networkService = networkService
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    func request<T: Decodable, E: HTTPInteractable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? where E.Response == T {
        return networkService.request(apiConfig: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                completion(result)
            case .failure(let error):
                completion(.failure(.networkFailure(error)))
            }
        }
    }
    
    func request<E: HTTPInteractable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<Void>
    ) -> URLSessionTask? where E.Response == Void {
        return networkService.request(apiConfig: endpoint) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.networkFailure(error)))
            }
        }
    }

    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder
    ) -> Result<T, DataTransferError> {
        do {
            guard let data = data else {
                return .failure(.noResponse)
            }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
}
