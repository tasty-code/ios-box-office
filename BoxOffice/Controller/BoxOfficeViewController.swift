//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    lazy var boxOfficeView: BoxOfficeView = BoxOfficeView()
    
    private var dataSource: [DailyBoxOffice.BoxOfficeMovie] = [] {
        didSet {
            boxOfficeView.boxOfficeCollectionView.reloadData()
        }
    }
    private let networkManager: NetworkManager
    
    init(dataSource: [DailyBoxOffice.BoxOfficeMovie] = [], networkManager: NetworkManager) {
        self.dataSource = dataSource
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDailyBoxOfficeData()
        view = boxOfficeView
        view.backgroundColor = .white
        boxOfficeView.boxOfficeCollectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "BoxOfficeCollectionViewCell")
        boxOfficeView.boxOfficeCollectionView.dataSource = self
        boxOfficeView.boxOfficeCollectionView.delegate = self
        configureRefreshControl()
    }
}

extension BoxOfficeViewController {
    private func loadDailyBoxOfficeData() {
        Task {
            let type: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: Date().getYesterday("yyyyMMdd"))
            guard let request = self.networkManager.makeRequest(type) else {
                return
            }
            let data = await self.networkManager.request(request, into: type) { networkError in
                DispatchQueue.main.async {
                    self.alert(with: networkError)
                }
            }
            guard let result = data as? BoxOfficeResult else {
                return
            }
            dataSource = result.converted()
            self.boxOfficeView.boxOfficeCollectionView.refreshControl?.endRefreshing()
            
        }
    }
    
    private func configureRefreshControl() {
        boxOfficeView.boxOfficeCollectionView.refreshControl = UIRefreshControl()
        boxOfficeView.boxOfficeCollectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        loadDailyBoxOfficeData()
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
        let (_, rank, rankChangedAmount, rankStatus, movieName, audienceCount, audienceAccumulated) = dataSource[indexPath.row].destructured()
        
        cell.rankLabel.text = rank
        cell.rankStatusLabel.text = rankStatus == "NEW" ? "신작" : "\(rankChangedAmount)"
        cell.movieNameLabel.text = movieName
        cell.audienceLabel.text = "오늘 \(audienceCount.formatNumber()) / 총 \(audienceAccumulated.formatNumber())"
        cell.accessories.append(.disclosureIndicator())
        return cell
    }
}
