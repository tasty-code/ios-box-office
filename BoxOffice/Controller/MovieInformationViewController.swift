//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    
    let movieInformationView: MovieInformationView = MovieInformationView()
    let movieCode: String
    
    private lazy var dataSource: MovieDataProvider = MovieDataProvider(movieCode: movieCode)
       
    init(movieCode: String, movieName: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = movieName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await loadInformation()
        }
    }
    
    override func loadView() {
        view = movieInformationView
    }
}

extension MovieInformationViewController {
    func loadInformation() async {
        do {
            let (movieInformation, posterData) = try await self.dataSource.loadMovieInformationData()
            DispatchQueue.main.async {
                self.movieInformationView.setData(movieInformationData: movieInformation, posterData: posterData)
            }
        } catch {
            print(error)
        }
    }
}
