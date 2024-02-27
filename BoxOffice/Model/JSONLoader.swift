import Foundation

struct JSONLoader {
    func loadJSONFromFile<T: Codable>(from bundle: Bundle, fileName: String, ofType fileType: String = "json") throws -> T {
        guard let path = bundle.path(forResource: fileName, ofType: fileType),
              let jsonString = try? String(contentsOfFile: path) else {
            throw JSONFileError.pathError(fileName: fileName)
        }
        guard let data = jsonString.data(using: .utf8) else { throw JSONFileError.utf8Error(fileName: fileName) }
        let decoder = JSONDecoder()
        return  try decoder.decode(T.self, from: data)
    }
}
