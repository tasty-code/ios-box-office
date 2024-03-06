//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    lazy var boxOfficeView: BoxOfficeView = BoxOfficeView()
    private let loadingIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @objc private var dataSource: DailyBoxOffice = DailyBoxOffice()
    private var observation: NSKeyValueObservation?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        observation = observe(
            \.dataSource.dailyBoxOfficeMovies,
            options: []
        ) { object, change in
            DispatchQueue.main.async {
                self.boxOfficeView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await loadDailyBoxOfficeData()
            boxOfficeView.boxOfficeCollectionView.isScrollEnabled = true
        }
        view = boxOfficeView
        view.backgroundColor = .white
        boxOfficeView.setBoxOfficeCollectionViewProperties(self, loadingIndicatorView: loadingIndicatorView)
        boxOfficeView.configureRefreshControl(self)
    }
    
    @objc func handleRefreshControl() {
        Task {
            await loadDailyBoxOfficeData()
        }
    }
}

extension BoxOfficeViewController {
    private func loadDailyBoxOfficeData() async {
        do {
            try await dataSource.loadDailyBoxOfficeData()
            self.loadingIndicatorView.stopAnimating()
            self.boxOfficeView.endRefreshControl()
        } catch {
            self.alert(with: error)
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.dailyBoxOfficeMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxOfficeCollectionViewCell", for: indexPath) as? BoxOfficeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(data: dataSource.dailyBoxOfficeMovies[indexPath.row])
        
        return cell
    }
}
