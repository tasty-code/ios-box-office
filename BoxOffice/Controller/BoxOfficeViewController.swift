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
            boxOfficeView.reloadData()
        }
    }
    private let networkManager: NetworkManager
    
    init(dataSource: [DailyBoxOffice.BoxOfficeMovie] = [], networkManager: NetworkManager) {
        self.dataSource = dataSource
        self.networkManager = networkManager
        self.loadingIndicatorView = UIActivityIndicatorView()
        super.init(nibName: nil, bundle: nil)
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
            let url: String = KoreanFilmCouncilURL.dailyBoxOffice(targetDate: Date().getYesterday("yyyyMMdd")).url
            let data: BoxOfficeResult = try await self.networkManager.request(url)
            self.loadingIndicatorView.stopAnimating()
            dataSource = data.converted()
            self.boxOfficeView.endRefreshControl()
        } catch {
            self.alert(with: error)
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
