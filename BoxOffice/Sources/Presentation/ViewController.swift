//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let boxOffice: BoxOfficeManager = BoxOfficeManager()
        let date = boxOffice.dailyFormatter()
        
        let dailyBoxOffice = KobisAPI.dailyBoxOffice(
            url: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            key: "2c7b3f6025093cbb1df0f1e819bf8c65",
            date: date
        )
        
        let detailMovie = KobisAPI.detailMovie(
            url: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
            key: "2c7b3f6025093cbb1df0f1e819bf8c65",
            code: "20124079"
        )
        
        boxOffice.requestDailyBoxOffice(kobisAPI: dailyBoxOffice, responseHandler: { result in
            switch result {
            case .success(let response):
                print("success: \(response)")
            case .failure(let error):
                print("failure: \(error.localizedDescription)")
            }
        })
        
        boxOffice.requestDetailMovie(kobisAPI: detailMovie, responseHandler: { result in
            switch result {
            case .success(let response):
                print("success: \(response)")
            case .failure(let error):
                print("failure: \(error.localizedDescription)")
            }
        })
        
//        boxOffice.requestDetailMovie(kobisAPI: <#T##KobisAPI#>, responseHandler: <#T##(Result<Any, Error>) -> ()#>)
//        sutBoxOffice.reqsuest(kobisAPI: dailyBoxOffice, responseHandler: { response in
//            guard let response = response?.boxOfficeResult else {
//                return
//            }
//            print("response--------1", response)
//        })
//        
//        sutBoxOffice.request(kobisAPI: detailMovie, responseHandler: { response in
//            guard let response = response?.boxOfficeResult else {
//                return
//            }
//            print("response--------2", response)
//        })
    }
}
