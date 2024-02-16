
import Foundation

struct NetworkManager {
    let urlSession = URLSession.shared
    let key = "ab168a1eb56e21306b897acd3d4653ce"
    
    func fetchDailyBoxOffice(date: String, completion: @escaping (BoxOfficeDataResponse?, Error?) -> Void) {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)") else { return }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, FetchError.invalidURL)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completion(nil, FetchError.invalidResponse)
                return
            }
            
            guard let data = data else { return }
            guard let movie = try? JSONDecoder().decode(BoxOfficeDataResponse.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            completion(movie, nil)
        }.resume()
    }
    
    func fetchDetail(code: String, completion: @escaping (MovieDetail?, Error?) -> Void) {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)") else { return }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, FetchError.invalidURL)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completion(nil, FetchError.invalidResponse)
                return
            }
            
            guard let data = data else { return }
            guard let movie = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            completion(movie, nil)
        }.resume()
    }
}
