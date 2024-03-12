
import Foundation

protocol JsonDecodeProtocol {
    func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkError>
}
