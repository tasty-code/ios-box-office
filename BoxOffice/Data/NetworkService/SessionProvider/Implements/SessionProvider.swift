
import Foundation

final class SessionProvider: SessionProvidable {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadAPIRequest(using urlRequest: URLRequest) async -> Result<NetworkResponse, NetworkError> {
        
        guard let (data, response) = try? await session.data(for: urlRequest)
        else { return .failure(.connectivity) }
        
        guard let httpResponse = response as? HTTPURLResponse
        else { return .failure(.notFound) }
        
        guard 200...299 ~= httpResponse.statusCode
        else { return .failure(.serverError(statusCode: httpResponse.statusCode)) }
        
        return .success(NetworkResponse(response: httpResponse, data: data))
    }
    
    private func printNetworkError(_ error: NetworkError) {
        print("Network Error: \(error.localizedDescription)")
    }

    
}
