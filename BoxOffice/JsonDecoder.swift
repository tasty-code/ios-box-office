
import Foundation

struct JsonDecoder<Element: Codable> {
    
    func loadData(from fileName: String, of fileType: String) -> Element? {
        
        guard let filePath = try? loadFilePath(from: fileName, of: fileType),
              let data = try? loadFileData(from: filePath),
              let jsonData = try? decodeFileData(from: data) else { return nil }

        return jsonData
    }
    
    private func loadFilePath(from fileName: String, of fileType: String) throws -> String {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            print("\(JsonParsingError.pathError.errorMessage)")
            throw JsonParsingError.pathError }
        return filePath
    }
    
    private func loadFileData(from filePath: String) throws -> Data {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            print("\(JsonParsingError.dataLoadError.errorMessage)")
            throw JsonParsingError.dataLoadError }
        return data
    }
    
    private func decodeFileData(from fileData: Data) throws -> Element {
        guard let jsonData = try? JSONDecoder().decode(Element.self, from: fileData) else {
            print("\(JsonParsingError.decodingError.errorMessage)")
            throw JsonParsingError.decodingError }
        return jsonData
    }
}
