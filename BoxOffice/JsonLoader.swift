import Foundation

struct JSONLoader {
    func loadJSON<T: Codable>(from bundle: Bundle, fileName: String, ofType fileType: String = "json") throws -> T {
        guard let path = bundle.path(forResource: fileName, ofType: fileType),
              let jsonString = try? String(contentsOfFile: path) else {
            throw ParsingError.pathError(fileName: fileName)
        }
        guard let data = jsonString.data(using: .utf8) else { throw ParsingError.utf8Error(fileName: fileName) }
        let decoder = JSONDecoder()
        return  try decoder.decode(T.self, from: data)
    }
}
