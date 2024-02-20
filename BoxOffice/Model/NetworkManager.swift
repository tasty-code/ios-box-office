
import Foundation

struct NetworkManager {
    private let urlSession = URLSession.shared
    private let key = "ab168a1eb56e21306b897acd3d4653ce"
    
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
            
            guard let data = data else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            guard let movie = try? JSONDecoder().decode(T.self, from: data) else {
                return
            }
            completion(movie, nil)
            
        }.resume()
    }
}



