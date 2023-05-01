//
//  ViewController.swift
//  BoxOffice
//
//  Created by M&A on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        networkManager.fetchDailyBoxOffice(endPoint: .dailyBoxOffice(date: "20230101")) { result in
//            switch result {
//            case .success(let boxOfficeResponse):
//                print(boxOfficeResponse)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
//        networkManager.fetchMovieDetail(endPoint: .movieDetail(movieCode: "20225061")) { result in
//            switch result {
//            case .success(let movieDetailResponse):
//                print(movieDetailResponse)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }
}
