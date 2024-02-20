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
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        fetchMovieDetailData(userKey: apiKey, movieCode: "20124079")
    }
    
    private func fetchMovieDetailData(userKey: String, movieCode: String) {
        MovieAPI.shared.requestMovieDetailAPI(userKey: userKey,
                                              movieCode: movieCode) { networkResult in
            switch networkResult {
                
            case .success(let data):
                if let data = data as? MovieInformation {
                    print(data)
                }
            case .pathError:
                print("pathErr")
            case .requestError(_):
                print("requestErr")
            case .networkFail:
                print("networkFail")
            case .serverError:
                print("serverErr")
                
            }
        }
    }
}
