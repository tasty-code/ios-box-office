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
        
        presentationProvider.movieInformationCall = {
            self.setupMovieInformationView()
        }
    }
}
