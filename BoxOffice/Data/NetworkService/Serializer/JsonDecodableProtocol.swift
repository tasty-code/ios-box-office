
import Foundation

protocol DecoderProtocol {
    func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkError>
    
}
