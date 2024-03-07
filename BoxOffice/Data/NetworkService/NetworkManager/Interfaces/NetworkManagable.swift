
import Foundation

protocol Networkmanagable {
    func bringNetworkResult<T: Decodable>(from url: URL) async -> Result<T, NetworkError>
}
