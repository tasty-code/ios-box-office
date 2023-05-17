//
//  Networking.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import UIKit

class Networking {
    func loadData<T: Convertable>(_ method: T.Type, request: URLRequest, completion: @escaping (MovieDatable?, Error?) -> Void) {

        URLSession.shared.dataTask(with: request) { data, response, error in
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
                completion(nil, NetworkError.missingData(response: response))
                return
            }

            guard let decodedData = try? JSONDecoder().decode(T.self, from: safeData) else {
                completion(nil, NetworkError.decodingError)
                return
            }

            completion(decodedData.convert(), nil)
        }.resume()
    }
}
