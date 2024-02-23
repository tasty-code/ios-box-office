//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkResponseData()
    }
    
    private func checkResponseData() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        let yesterday = Date.convertYesterdayDateToString()
        let movieCode = "20236180"
        
        fetchBoxOfficeData(userKey: apiKey, date: yesterday)
        fetchMovieDetailData(userKey: apiKey, movieCode: movieCode)
    }
    
    private func fetchMovieDetailData(userKey: String, movieCode: String) {
        MovieAPI.shared.requestMovieDetailAPI(userKey: userKey,
                                              movieCode: movieCode) { networkResult in
            switch networkResult {
                
            case .success(let data):
                if let movieInfo = data as? MovieInformation {
                    print(movieInfo)
                }
            default:
                handleError(networkResult)
            }
        }
    }
    
    private func fetchBoxOfficeData(userKey: String, date: String) {
        BoxOfficeAPI.shared.requestDailyBoxOfficeAPI(userKey: userKey,
                                                     date: date) { networkResult in
            switch networkResult {
                
            case .success(let data):
                if let boxOfficeData = data as? BoxOfficeData {
                    print(boxOfficeData)
                }
            default:
                handleError(networkResult)
            }
        }
        
    }
}

private func handleError(_ networkResult: NetworkResult<Any>) {
    switch networkResult {
        
    case .pathError:
        print("pathErr")
    case .requestError(_):
        print("requestErr")
    case .networkFail:
        print("networkFail")
    case .serverError:
        print("serverErr")
        
    default:
        break
    }
}
