
import Foundation

struct JsonDecoder: DecoderProtocol {
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkError> {
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data)
        else { return .failure(.decodingError) }
        return .success(decodedData)
    }
}
