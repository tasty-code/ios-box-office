
import Foundation

protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(from request: URLRequest) async -> Result<T, NetworkError>
}
