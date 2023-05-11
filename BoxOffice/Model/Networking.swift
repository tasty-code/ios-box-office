//
//  Networking.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import UIKit

class Networking {
    func loadData(_ method: EndPoint, completion: @escaping (MovieDatable?, Error?) -> Void) {
        do {
            let urlRequest = try method.makeRequest()

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

                guard let decodedData = self.loadJSON(method.convertType, data: safeData) as? Convertable else {
                    completion(nil, NetworkError.decodingError)
                    return
                }

                completion(decodedData.convert(), nil)
            }.resume()
        } catch {
            completion(nil, error)
        }
    }

    func loadImage(_ method: EndPoint, completion: @escaping (UIImage?, Error?) -> Void) {
        loadData(method) { poster, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let poster = poster as? MoviePoster else {
                completion(nil, NetworkError.decodingError)
                return
            }

            let posterURL = poster.url.replacingOccurrences(of: "http://", with: "https://")

            guard let url = URL(string: posterURL) else {
                completion(nil, NetworkError.decodingError)
                return
            }

            print(#line, url)

            if let data = try? Data(contentsOf: url) {
                completion(UIImage(data: data), nil)
            }
        }
    }

    private func loadJSON<T: Convertable>(_ method: T.Type, data: Data) -> Decodable? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(method, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}
