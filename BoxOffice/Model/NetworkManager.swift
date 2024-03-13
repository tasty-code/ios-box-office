import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

struct NetworkManager: NetworkManagerProtocol {
    private func loadJSONFromURL<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "URLError", code: 404, userInfo: nil)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
            completion(.failure(NSError(domain: "URLSession.shared.dataTask Error", code: 500, userInfo: nil)))
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
    
    func fetch <T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        loadJSONFromURL(from: urlString, completion: completion)
    }
    
}
