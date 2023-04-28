//
//  Networking.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import UIKit

class Networking {
    func loadData(request: String, completion: @escaping (DailyBoxOffice?, Error?) -> Void) {

        do {
            let url = try URLPath.dailyBoxOffice.configureURL(request)
            var urlRequest = URLRequest(url: url)

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    completion(nil, NetworkError.transportError)
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    completion(nil, NetworkError.serverError)
                    return
                }

                guard let safeData = data else {
                    completion(nil, NetworkError.missingData)
                    return
                }

                guard let decodedData = try JSONDecoder().decode(BoxOfficeDTO.self, from: safeData) else {
                    completion(nil, NetworkError.decodingError)
                    return
                }
                completion(decodedData.convert(), nil)
            }.resume()
        } catch {
            completion(nil, URLComponentsError.invalidComponent)
        }
    }
}
