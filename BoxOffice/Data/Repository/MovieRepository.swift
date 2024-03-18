
import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    private let sessionProvider: SessionProvidable
    private let decoder: DecoderProtocol
    
    init(sessionProvider: SessionProvidable, decoder: DecoderProtocol) {
        self.sessionProvider = sessionProvider
        self.decoder = decoder
    }
    
    func requestBoxOfficeData<T: Decodable>() async -> Result<T, NetworkError> {
        guard let request = RequestProvider(requestInformation: .dailyMovie).request else {
            return .failure(.requestError)
        }
        return await makeRequestAndDecode(request: request)
    }
    
    func requestDetailMovieData<T: Decodable>(movieCode: String) async -> Result<T, NetworkError> {
        guard let request = RequestProvider(requestInformation: .detailMovie(code: movieCode)).request else {
            return .failure(.requestError)
        }
        return await makeRequestAndDecode(request: request)
    }

    private func makeRequestAndDecode<T: Decodable>(request: URLRequest) async -> Result<T, NetworkError> {
        let result: Result<NetworkResponse, NetworkError> = await sessionProvider.requestAPI(using: request)
        
        switch result {
        case .success(let networkResponse):
            guard let data = networkResponse.data else { return .failure(.connectivity) }
            print(data)
            return decoder.decode(data)
            
        case .failure(let networkError):
            logNetworkError(networkError)
            return .failure(.connectivity)
        }
    }
    
    private func logNetworkError(_ error: NetworkError) {
        print("Network Error: \(error.localizedDescription)")
    }
}
