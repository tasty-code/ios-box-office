//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private let networking = NetworkManager.shared
    private let networkAPI = NetworkAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDailyBoxOfficeAPI()
        callMovieDetailAPI()
    }
    
    private func callMovieDetailAPI() {
        let url = networkAPI.buildMovieDetailAPI(movieCode: .movieCode)
        networking.performRequest(with: url) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let decodedData = JSONParser().parseJSON(data as! Data, DTO: MovieDetailDTO.self)
                else {
                    return
                }
                print(decodedData.movieInfoResult.movieInfo.companys)
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
                      let decodedData = JSONParser().parseJSON(data as! Data, DTO: DailyBoxOfficeResultDTO.self)
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
