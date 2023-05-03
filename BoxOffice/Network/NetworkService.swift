//
//  NetworkService.swift
//  BoxOffice
//
//  Created by 신동오 on 2023/05/03.
//

import Foundation

struct NetworkService {
    
    static func fetchBoxOfficeData(date: String, completion: @escaping (DailyBoxOfficeDTO?) -> Void) {
        URLSession.shared.dataTask(with: API.boxofficeMovie(date: date).urlRequest) { data, _, _ in
            guard let data = data else { return }
            let parsedData = try? JSONDecoder().decode(DailyBoxOfficeDTO.self, from: data)
            completion(parsedData)
        }.resume()
    }
    
}
