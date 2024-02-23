//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    lazy var boxOfficeView: BoxOfficeView = BoxOfficeView()
    private let loadingIndicatorView: UIActivityIndicatorView
    
    private var dataSource: [DailyBoxOffice.BoxOfficeMovie] = [] {
        didSet {
            boxOfficeView.boxOfficeCollectionView.reloadData()
        }
    }
    private let networkManager: NetworkManager
    
    init(dataSource: [DailyBoxOffice.BoxOfficeMovie] = [], networkManager: NetworkManager, loadingIndicatorView: UIActivityIndicatorView) {
        self.dataSource = dataSource
        self.networkManager = networkManager
        self.loadingIndicatorView = loadingIndicatorView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await loadDailyBoxOfficeData()
        }
        boxOfficeView.boxOfficeCollectionView.backgroundView = loadingIndicatorView
        loadingIndicatorView.startAnimating()
        view = boxOfficeView
        view.backgroundColor = .white
        boxOfficeView.boxOfficeCollectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "BoxOfficeCollectionViewCell")
        boxOfficeView.boxOfficeCollectionView.dataSource = self
        boxOfficeView.boxOfficeCollectionView.delegate = self
        configureRefreshControl()
    }
}

extension BoxOfficeViewController {
    private func loadDailyBoxOfficeData() async {
        do {
            let url: String = KoreanFilmCouncilURL.dailyBoxOffice(targetDate: Date().getYesterday("yyyyMMdd")).url
            let data: BoxOfficeResult = try await self.networkManager.request(url)
            self.loadingIndicatorView.stopAnimating()
            dataSource = data.converted()
            self.boxOfficeView.boxOfficeCollectionView.refreshControl?.endRefreshing()
        } catch {
            self.alert(with: error)
        }
    }
    
    private func configureRefreshControl() {
        boxOfficeView.boxOfficeCollectionView.refreshControl = UIRefreshControl()
        boxOfficeView.boxOfficeCollectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        Task {
            await loadDailyBoxOfficeData()
        }
    }
}


extension BoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxOfficeCollectionViewCell", for: indexPath) as? BoxOfficeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(data: dataSource[indexPath.row].destructed())
        
        return cell
    }
}

class LoadingIndicator {
    let loadingIndicatorView = UIActivityIndicatorView()
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicatorView.startAnimating()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicatorView.removeFromSuperview()
        }
    }
}
