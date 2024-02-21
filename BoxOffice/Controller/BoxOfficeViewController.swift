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
        loadData()
        view = boxOfficeView
        boxOfficeView.boxOfficeCollectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "BoxOfficeCollectionViewCell")
        boxOfficeView.boxOfficeCollectionView.dataSource = self
        boxOfficeView.boxOfficeCollectionView.delegate = self
    }
}

//func setupContraints()

extension BoxOfficeViewController {
    private func loadData() {
        Task {
            let type: KoreanFilmCouncilURL = .dailyBoxOffice(queryValue: "20240220")
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
            print(dataSource)
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
        let (_, rank, rankChangedAmount, rankStatus, movieName, audienceCount, audienceAccumulated) = dataSource[indexPath.row].destructured()
        
        cell.rankLabel.text = rank
        cell.rankStatusLabel.text = rankStatus == "NEW" ? "신작" : "\(rankChangedAmount)"
        cell.movieNameLabel.text = movieName
        cell.audienceLabel.text = "오늘 \(audienceCount.formatNumber()) / 총 \(audienceAccumulated.formatNumber())"
        return cell
    }
}
