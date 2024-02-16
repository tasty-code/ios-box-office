import Foundation

class JsonLoader {
    static func loadjson(fileName: String) -> Data? {
        guard let fileLocation = Bundle(for: BoxOfficeModelTests.self).path(forResource: fileName, ofType: "json") else {
            print("notFound")
            return nil
        }
        do {
            let jsonData = try String(contentsOfFile: fileLocation)
            return jsonData.data(using: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
}
