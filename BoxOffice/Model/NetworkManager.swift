
import Foundation

struct NetworkManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Codable>(url: String, parse: @escaping (Data) throws -> T, completion: @escaping (T?, Error?) -> Void) {
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
            
            do {
                guard let  data = data else { return }
                let parseData = try parse(data)
                completion(parseData, nil)
            } catch {
                completion(nil, FetchError.invalidData)
            }
            
        }.resume()
    }
}



