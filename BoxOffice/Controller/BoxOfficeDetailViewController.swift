//
//  BoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Matthew on 3/8/24.
//

import UIKit

final class BoxOfficeDetailViewController: UIViewController {
    
    private let movieName: String
    private let movieManger: MovieManager
    private let scrollView = BoxOfficeDetailView()
    private var receivedData: Data?
    
    init(movieName: String, movieManger: MovieManager) {
        self.movieName = movieName
        self.movieManger = movieManger
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = scrollView
        view.backgroundColor = .white
        setupMovieImage()
    }
    
    func setupMovieImage() {
        movieManger.fetchMoiveImageData(movieName: movieName) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.scrollView.movieImageView.image = self.movieManger.loadImage(data: data)
                }
            case .failure(let failure):
                print("fetchMoiveImageData 실패: \(failure)")
            }
        }
    }
}
