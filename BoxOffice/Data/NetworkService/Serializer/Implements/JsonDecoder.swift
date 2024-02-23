
import Foundation


struct URLDecoder: URLDecodeProtocol {
    
    func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkError> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else { return .failure(.decodingError) }
        return .success(decodedData)
    }
}
