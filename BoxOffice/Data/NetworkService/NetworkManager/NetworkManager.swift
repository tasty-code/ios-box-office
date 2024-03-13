
import Foundation

final class NetworkManager: NetworkManagerProtocol {
    private let session: SessionProvidable
    private let decoder: DecoderProtocol
    
    init(sessionProvider: SessionProvidable, decoder: DecoderProtocol) {
        self.session = sessionProvider
        self.decoder = decoder
    }
    
    func performRequest<T: Decodable>(from request: URLRequest) async -> Result<T, NetworkError> {
        
        let result = await session.requestAPI(using: request)
        
        switch result {
        case .success(let networkResponse):
            guard let data = networkResponse.data else { return .failure(.connectivity) }
            return decoder.decode(data)
        case .failure(let networkError):
            return .failure(networkError)
        }
    }
}
