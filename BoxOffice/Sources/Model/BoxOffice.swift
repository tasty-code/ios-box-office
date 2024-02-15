//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Roh on 2/14/24.
//

import Foundation

class BoxOffice {
    private var urlRequest: URLRequest?
    private let group = DispatchGroup()
    
    func startLoad() {
        
    }
    
    func request() -> URLRequest? {
        guard let url = setURL() else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    func response(request: URLRequest)  {
        setSession(request: request, completionHandler: { result in
            switch result {
            case .success(let response):
                print("success \(response)")
            case .failure(let error):
                print("failure \(error.localizedDescription)")
            }
        })
//        DispatchQueue.global().async(group: group) { [self] in
//            
//            group.leave()
//        }
    }
    
    private func setSession(request: URLRequest, completionHandler: @escaping (Result) -> ())  {
        
        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            let successRange: Range = (200..<300)
            // 통신 성공
            guard let data: Data = data,
                    error == nil
            else {
                completionHandler(.failure(NetworkError.invalidURL))
                return
            }
            
            if let response: HTTPURLResponse = response as? HTTPURLResponse {
                debugPrint("status code: \(response.statusCode)")
                
                // 요청 성공 (StatusCode가 200번대)
                if successRange.contains(response.statusCode){
                    // decode
                    guard let userInfo: BoxOfficeResponse = try? JSONDecoder().decode(BoxOfficeResponse.self, from: data) else { return
                    }
                    completionHandler(.success(userInfo))
                } else { //요청 실패 (Status code가 200대 아님)
                    completionHandler(.failure(NetworkError.serverError(code: response.statusCode)))
                }
            }
            
        }.resume()
    }
    
    
    private func setURL() -> URL? {
        let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        let keyValue = "2c7b3f6025093cbb1df0f1e819bf8c65"
        let targetDtValue = "20240212"
        
        guard var urlComponents: URLComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: keyValue),
            URLQueryItem(name: "targetDt", value: targetDtValue)
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
}
