//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/17.
//

import UIKit

class MovieInformationViewController: UIViewController {
    
    private let presentationProvider = PresentationProvider()

    init(movieCode: String) {
        presentationProvider.updateMovieCode(movieCode)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }
}
