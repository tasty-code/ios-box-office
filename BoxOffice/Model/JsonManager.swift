//
//  JsonManager.swift
//  BoxOffice
//
//  Created by Jin-Mac on 2/15/24.
//

import Foundation

class JsonManager {
    var decodedData: BoxOfficeData?
    
    func loadJson() {
        if let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101") {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if let data = data {
                    
                    do {
                        decodedData = try JSONDecoder().decode(BoxOfficeData.self, from: data)
                        print(decodedData?.boxOfficeResult.dailyBoxOfficeList.count)
                        dump(decodedData)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
