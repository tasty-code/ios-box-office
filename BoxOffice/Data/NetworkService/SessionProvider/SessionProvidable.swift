
import Foundation

protocol SessionProvidable {
    func requestAPI (using urlRequest: URLRequest) async -> Result<NetworkResponse, NetworkError>
}
