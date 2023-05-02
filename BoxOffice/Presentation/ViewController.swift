//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    let boxOfficeDTO = BoxOfficeRequestDTO(targetDate: "20230501")
    let moiveDetailDTO = MovieDetailRequestDTO(movieCode: "20226270")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let boxOfficeResult = try await networkService.request(with: APIEndPoint.receiveBoxOffice(with: boxOfficeDTO))
            print(boxOfficeResult)
            
            let movieDetailResult = try await networkService.request(with: APIEndPoint.receiveMovieDetailInformation(with: moiveDetailDTO))
            print(movieDetailResult)
        }
    }

}
