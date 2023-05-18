//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/17.
//

import UIKit

class MovieInformationViewController: UIViewController {
    
    private let presentationProvider = PresentationProvider()
    private let movieInformationView = MovieInformationView()
    private lazy var indicatorView = ActivityIndicatorView(frame: view.bounds)
    
    init(movieCode: String) {
        presentationProvider.updateMovieCode(movieCode)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupMovieInformationView()
        configureMovieInformation()
    }
    
    override func loadView() {

        self.view = movieInformationView
    }
    
    private func setupMovieInformationView() {
        let movieInformation = presentationProvider.getMovieInformation()
        movieInformationView.information = movieInformation
    }
    
    func configureMovieInformation() {
        
        presentationProvider.movieInformationCall = { [weak self] in
            self?.setupMovieInformationView()

            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(indicatorView)
    }
}
