
import Foundation

final class NetworkManager: NetworkManagerProtocol {
    private let session: SessionProvidable
    private let decoder: JsonDecodeProtocol
    
    init(sessionProvider: SessionProvidable, decoder: JsonDecodeProtocol) {
        self.session = sessionProvider
        self.decoder = decoder
    }
    
    func bringNetworkResult<T: Decodable>(from request: URLRequest) async -> Result<T, NetworkError> {
        
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
