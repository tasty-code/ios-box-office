//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

class MovieInformationViewController: UIViewController {
    
    let movieInformationView: UIView = MovieInformationView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = movieInformationView
        view.backgroundColor = .white
    }
}
