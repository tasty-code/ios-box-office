
import Foundation

protocol NetworkManagerProtocol {
    func bringNetworkResult<T: Decodable>(from request: URLRequest) async -> Result<T, NetworkError>
}
