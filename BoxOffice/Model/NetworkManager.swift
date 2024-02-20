
import Foundation

struct NetworkManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Codable>(url: String, type: T.Type, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, FetchError.invalidURL)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                completion(nil, FetchError.invalidResponse)
                return
            }
            
            
            guard let  data = data, let movie = try? JSONDecoder().decode(T.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            completion(movie, nil)
            
        }.resume()
    }
}



