//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit
import OSLog
final class MovieListViewController: UIViewController {
    
    private let networking = NetworkManager.shared
    private let networkAPI = NetworkAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        callDailyBoxOfficeAPI()
        callMovieDetailAPI()

        os_log("네트워크 오류남", log: .network, type: .error)
        os_log("네트워크 오류남", type: .error)
        os_log("default")
    }
    
    private func callMovieDetailAPI() {
        let url = networkAPI.buildMovieDetailAPI(movieCode: .movieCode)
        networking.performRequest(with: url) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let decodedData = JSONParser().decode(data as! Data, DTO: DailyBoxOfficeResultDTO.self)
                else {
                    return
                }
                print(decodedData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func callDailyBoxOfficeAPI() {
        let url = networkAPI.buildDailyBoxOfficeAPI(targetDate: .targetDate, keys: .itemPerPage, values: "2")
        networking.performRequest(with: url) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let decodedData = JSONParser().decode(data as! Data, DTO: DailyBoxOfficeResultDTO.self)
                else {
                    return
                }
                print(decodedData,"\n -------------------------")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let network = OSLog(subsystem: subsystem, category: "Network")
}
