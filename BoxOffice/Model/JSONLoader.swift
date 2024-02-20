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
    
    func loadJSONFromURL<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.dataLoadingError))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
