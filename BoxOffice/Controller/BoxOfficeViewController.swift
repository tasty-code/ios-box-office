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
    
    private lazy var dataSource: any LoadDataProtocol = {
        let dataSource = DailyBoxOffice()
        dataSource.delegate = self
        return dataSource
    }()

    override func loadView() {
        view = boxOfficeView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicatorView.startAnimating()
        Task {
            await loadDailyBoxOfficeData()
            boxOfficeView.boxOfficeCollectionView.isScrollEnabled = true
        }
        boxOfficeView.setBoxOfficeCollectionViewProperties(self, loadingIndicatorView: loadingIndicatorView)
        boxOfficeView.setBoxOfficeCollectionViewDelegate(self)
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
            try await dataSource.loadData()
            self.loadingIndicatorView.stopAnimating()
            self.boxOfficeView.endRefreshControl()
        } catch {
            self.alert(with: error)
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.loadedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.className, for: indexPath) as? BoxOfficeCollectionViewCell,
              let data = dataSource.loadedData as? [DailyBoxOffice.Movie] else {
            return UICollectionViewCell()
        }
        
        cell.configure(data: data[indexPath.row])
        
        return cell
    }
}

extension BoxOfficeViewController: DataDelegate {
    func reloadView() {
        DispatchQueue.main.async {
            self.boxOfficeView.reloadData()
        }
    }
    
}
