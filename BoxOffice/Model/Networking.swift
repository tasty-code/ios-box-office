//
//  Networking.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/04/28.
//

import UIKit

class Networking {
    func loadData(from method: EndPoint, completion: @escaping (MovieDatable?, Error?) -> Void) {
        do {
            let urlRequest = try method.makeRequest()

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    completion(nil, NetworkError.transportError)
                    return
                }

                if let httpError = self.handleHTTPError(data: data, from: method, with: response) {
                    completion(nil, httpError)
                    return
                }

                guard let safeData = data else {
                    completion(nil, NetworkError.missingData)
                    return
                }

                guard let decodedData = try? JSONDecoder().decode(method.convertType, from: safeData) else {
                    completion(nil, NetworkError.decodingError)
                    return
                }

                completion(decodedData.convert(), nil)
            }.resume()
        } catch {
            completion(nil, error)
        }
    }

    func loadImage(form method: EndPoint, completion: @escaping (UIImage?, Error?) -> Void) {
        loadData(from: method) { poster, error in
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

            if let data = try? Data(contentsOf: url) {
                completion(UIImage(data: data), nil)
            }
        }
    }

    private func handleHTTPError(data: Data?, from method: EndPoint, with response: URLResponse?) -> HTTPError? {
        guard let data = data,
              let httpCode = (response as? HTTPURLResponse)?.statusCode else {
            return HTTPError.notFound
        }

        switch method {
        case .moviePoster:
            if !(200...299).contains(httpCode),
               let decodedData = try? JSONDecoder().decode(ErrorDTO.self, from: data),
               let httpError = decodedData.convert(with: httpCode) {
                return httpError
            }
        case .dailyBoxOffice, .movieInformation:
            if let decodedData = try? JSONDecoder().decode(KoficErrorDTO.self, from: data),
               let httpError = decodedData.faultInfo?.convert(with: httpCode) {
                return httpError
            }
        }

        return nil
    }
}
