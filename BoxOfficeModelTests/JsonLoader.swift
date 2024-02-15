import Foundation

class JsonLoader {
    func loadjson() -> BoxOfficeResponseDTO? {
        guard let fileLocation = Bundle(for: BoxOfficeModelTests.self).path(forResource: "box_office_sample", ofType: "json") else {
            print("notFound")
            return nil
        }
        do {
            let jsonData = try String(contentsOfFile: fileLocation)
            let decoder = JSONDecoder()
            let data = jsonData.data(using: .utf8)
            let dataFromJson = try decoder.decode(BoxOfficeResponseDTO.self, from: data!)
            return dataFromJson
        } catch {
            print(error)
            return nil
        }
    }
}
