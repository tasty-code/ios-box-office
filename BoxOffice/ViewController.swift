//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {

    private let boxOfficeManager = BoxOfficeAPIManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDailyBoxOffice()
        fetchMovieDetail()
    }

    private func fetchDailyBoxOffice() {
        boxOfficeManager.fetchData(to: BoxOffice.self, endPoint: BoxOfficeAPIEndpoints.boxOffice(targetDate: "20230426")) { decodedData in
            print(decodedData)
        }
    }

   private func fetchMovieDetail() {
        boxOfficeManager.fetchData(to: MovieDetail.self, endPoint: BoxOfficeAPIEndpoints.movieDetail(movieCode: "20227890")) { decodedData in
            print(decodedData)
        }
    }

}

