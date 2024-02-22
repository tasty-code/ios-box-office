
import Foundation

protocol SessionProvidable {
    func loadAPIRequest (using urlRequest: URLRequest) async -> Result<NetworkResponse, NetworkError>
}
