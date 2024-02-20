import Foundation

protocol DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void)
}

extension DispatchQueue: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: Requestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? where E.Response == T
    
    @discardableResult
    func request<T: Decodable, E: Requestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? where E.Response == T

    @discardableResult
    func request<E: Requestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<Void>
    ) -> URLSessionTask? where E.Response == Void
    
    @discardableResult
    func request<E: Requestable>(
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
    
    func request<T: Decodable, E: Requestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? where E.Response == T {
        return networkService.request { result in
            switch result {
            case .success(let data):
                let result: Result<T, Error> = self.decode(data: data, decoder: endpoint.responseDecoder)
                queue.asyncExecute { completion(result) }
            case .failure(let error):
                queue.asyncExecute { completion(.failure(error)) }
            }
        }
    }
    
    func request<T: Decodable, E: Requestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> URLSessionTask? where E.Response == T {
        return request(with: endpoint, on: DispatchQueue.main, completion: completion)
    }

    func request<E>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping CompletionHandler<Void>
    ) -> URLSessionTask? where E: Requestable, E.Response == Void {
        return networkService.request { result in
            switch result {
            case .success:
                queue.asyncExecute { completion(.success(())) }
            case .failure(let error):
                queue.asyncExecute { completion(.failure(error)) }
            }
        }
    }

    func request<E>(
        with endpoint: E,
        completion: @escaping CompletionHandler<Void>
    ) -> URLSessionTask? where E: Requestable, E.Response == Void {
        return request(with: endpoint, on: DispatchQueue.main, completion: completion)
    }

    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder
    ) -> Result<T, Error> {
        do {
            guard let data = data else {
                return .failure(NetworkError.dataError)
            }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
