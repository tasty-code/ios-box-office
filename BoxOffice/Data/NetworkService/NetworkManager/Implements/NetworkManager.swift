
import Foundation


class NetworkManager: Networkmanagable {
    
    private let sessionProvider: SessionProvidable
    private let decoder: URLDecodeProtocol
    
    init(sessionProvider: SessionProvidable, decoder: URLDecodeProtocol) {
        self.sessionProvider = sessionProvider
        self.decoder = decoder
    }
    
    func bringNetworkResult<T: Decodable>(from url: URL) async -> Result<T, NetworkError> {
        guard let request = makeURLRequest(from: url)
        else { return .failure(.urlError) }
        
        let result = await sessionProvider.loadAPIRequest(using: request)
        
        switch result {
        case .success(let networkResponse):
            guard let data = networkResponse.data else { return .failure(.connectivity) }
            return decoder.decode(data)
        case .failure(let networkError):
            return .failure(networkError)
        }
    }
    
    private func makeURLRequest(from url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
