
import Foundation

struct NetworkManager {
    func fetchDailyBoxOffice(completion: @escaping (BoxOfficeDataResponse?, Error?) -> Void) {
        guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=ab168a1eb56e21306b897acd3d4653ce&targetDt=20240210") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            guard let movie = try? JSONDecoder().decode(BoxOfficeDataResponse.self, from: data) else { return }
            completion(movie, nil)
        }.resume()
    }
}
