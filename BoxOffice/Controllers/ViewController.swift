//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController, NetworkServable {
    
    private var dailyBoxOffice: DailyBoxOfficeDTO?
    private var movieDetail: MovieDetailDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sample = API.dailyBoxOffice(date: "20220101")
        updateData(from: sample)
        
    }
    
    func updateData(from api: API) {
        fetchData(apiType: api) { result in
            switch result {
            case .success(let data):
                self.dailyBoxOffice = data as? DailyBoxOfficeDTO
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

