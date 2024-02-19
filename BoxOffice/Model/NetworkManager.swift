
import Foundation

struct NetworkManager {
    private let urlSession = URLSession.shared
    private let key = "ab168a1eb56e21306b897acd3d4653ce"
    private var urlComponents = URLComponents()

    mutating func fetchDailyBoxOffice() {
        let modifyUrl = modifyUrlComponent(path: MovieOffice.DailyUrl)
        let finalUrl = modifyUrl?.appending("targetDt", value: "20240101")
        taskUrl(finalUrl: finalUrl, type:BoxOfficeData.self )
    }
    
    mutating func fetchInfoBoxOffice() {
        let modifyUrl = modifyUrlComponent(path: MovieOffice.InfoUrl)
        let finalUrl = modifyUrl?.appending("movieCd", value: "20124079")
        taskUrl(finalUrl: finalUrl, type:MovieDetail.self )
    }
    
    func taskUrl<T: Codable>(finalUrl: URL?, type: T.Type) {
        guard let url = finalUrl else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                return
            }
            guard let data = data else {
                return
            }
            guard let movie = try? JSONDecoder().decode(T.self, from: data) else {
               return
            }
        }
        dataTask.resume()
    }
    
    mutating func modifyUrlComponent(path: String) -> URL? {
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = "\(path)"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "ab168a1eb56e21306b897acd3d4653ce")
        ]
        
        return urlComponents.url
    }
}



