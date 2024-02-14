import Foundation

struct JsonLoader {
    func loadjson() -> BoxOfficeDTO? {
        guard let fileLocation = Bundle.main.url(forResource: "resources/box_office_sample", withExtension: "json") else {
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            let dataFromJson = try decoder.decode(BoxOfficeDTO.self, from: jsonData)
            return dataFromJson
        } catch {
            print(error)
            return nil
        }
    }
}
