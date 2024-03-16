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
    
    private lazy var dataSource: any MovieInformationViewControllerDataSource = {
       let dataSource = MovieDataProvider(movieCode: movieCode)
        dataSource.delegate = self
        return dataSource
    }()

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
        view.backgroundColor = .white
    }
}

extension MovieInformationViewController: DataDelegate {
    func reloadView() {
        guard let data = dataSource as? MovieDataProvider,
        let loadedData = data.loadedData,
        let posterData = data.posterData else {
            return
        }
        DispatchQueue.main.async {
            self.movieInformationView.setData(loadedData: loadedData, posterData: posterData)
        }
    }
}

extension MovieInformationViewController {
    func loadInformation() async {
        do {
            try await self.dataSource.loadMovieInformationData()
        } catch {
            print(error)
        }
    }
}
