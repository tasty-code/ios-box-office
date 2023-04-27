//
//  ViewController.swift
//  BoxOffice
//
//  Created by M&A on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkRouter = NetworkRouter()
    private lazy var networkManager = NetworkManager(router: networkRouter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchMovie(movieAPI: .dailyBoxOffice(date: "20230101")) { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
