
import Foundation

protocol URLDecodeProtocol {
    func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkError>
}
