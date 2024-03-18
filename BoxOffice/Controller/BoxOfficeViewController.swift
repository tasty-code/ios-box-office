//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
 
    private let boxOfficeView: BoxOfficeView = BoxOfficeView()
    private let loadingIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var dataSource: any BoxOfficeViewControllerDataSource = {
        let dataSource = BoxOfficeProvider()
        dataSource.delegate = self
        return dataSource
    }()

    override func loadView() {
        view = boxOfficeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeView.delegate = self
        setNavigationItemTitle(Date.yesterday)
        loadingIndicatorView.startAnimating()
        
        Task {
            await loadDailyBoxOfficeData()
            boxOfficeView.boxOfficeCollectionView.isScrollEnabled = true
        }
        boxOfficeView.setBoxOfficeCollectionViewProperties(loadingIndicatorView: loadingIndicatorView)
        boxOfficeView.setBoxOfficeCollectionViewDelegate(self)
        boxOfficeView.configureRefreshControl(self)
    }
}

extension BoxOfficeViewController {
    private func setNavigationItemTitle(_ date: Date) {
        self.navigationItem.title = date.formatted(using: .standard)
    }
}

extension BoxOfficeViewController: BoxOfficeCollectionViewDelegate {
    func loadDailyBoxOfficeData() async {
        do {
            try await dataSource.loadBoxOfficeData()
        } catch {
            guard let networkError = error as? NetworkError else {
                print(error.localizedDescription)
                return
            }
            self.alert(with: networkError)
        }
        self.loadingIndicatorView.stopAnimating()
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.loadedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.className, for: indexPath) as? BoxOfficeCollectionViewCell,
              let movies = dataSource.loadedData as? [BoxOfficeProvider.Movie],
              let data = movies[safeIndex: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.configure(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = dataSource.loadedData as? [BoxOfficeProvider.Movie],
              let movieCode = movies[safeIndex: indexPath.row]?.movieCode, let movieName = movies[safeIndex: indexPath.row]?.movieName else {
            return
        }
        let movieInformationViewController: UIViewController = MovieInformationViewController(movieCode: movieCode, movieName: movieName)
        self.navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}

extension BoxOfficeViewController: DataDelegate {
    func reloadView() {
        DispatchQueue.main.async {
            self.boxOfficeView.reloadData()
        }
    }
}
