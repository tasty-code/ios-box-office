//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    let networkService = NetworkService()
    var testEntity = [DailyBoxOffice]()

    //MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        fetchData()
    }

    //MARK: - Private Property

    private lazy var navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: receiveCurrentDate())
        navigationBar.setItems([navigationItem], animated: true)
        navigationBar.isTranslucent = false

        return navigationBar
    }()
    
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl) , for: .valueChanged)

        return refreshControl
    }()
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refresh.endRefreshing()
        }
    }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: configureOfCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        collectionView.refreshControl = refresh

        return collectionView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!

    private func fetchData() {
        let yesterdayDate = receiveCurrentDate().split(separator: "-").joined()
        let boxOfficeRequestDTO = BoxOfficeRequestDTO(targetDate: yesterdayDate)

        var networkResult: BoxOfficeResult?

        Task {
            let result = try await networkService.request(with: APIEndPoint.receiveBoxOffice(with: boxOfficeRequestDTO))
            networkResult = result.boxOfficeResult
            networkResult?.dailyBoxOfficeList.forEach({ officeList in
                testEntity.append(DailyBoxOffice(movieBrief: MovieBrief(movieName: officeList.movieName, audienceCount: officeList.audienceCount, audienceAccumulated: officeList.audienceAccumulate), rank: Rank(rank: officeList.rank, rankVariation: officeList.rankVariation, rankOldAndNew: officeList.rankOldAndNew)))
            })
            applySnapshot()
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(testEntity)
        dataSource.apply(snapshot)
    }
}

//MARK: - Configure of CollectionViewLayout
extension HomeViewController {
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide

        self.view.backgroundColor = .white
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])

        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor)
        ])
    }

    private func configureOfCollectionViewLayout() -> UICollectionViewLayout {
        let configure = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
        return layout
    }
}

//MARK: - Configure of DiffableDataSource
extension HomeViewController {
    func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOffice> { [self] (cell, indexPath, dailyBoxOffice) in
            let rankVariation = determineRankVariation(with: dailyBoxOffice.rank.rankVariation, and: dailyBoxOffice.rank.rankOldAndNew)
            let rankImage = determineVariationImage(with: dailyBoxOffice.rank.rankVariation)
            
            cell.boxOfficeBrief.setMovieName(by: dailyBoxOffice.movieBrief.movieName)
            cell.boxOfficeBrief.setAudienceCount(by: convertToNumberFormatter(dailyBoxOffice.movieBrief.audienceCount,
                                                                                   accumulated: dailyBoxOffice.movieBrief.audienceAccumulated))
            cell.boxOfficeRank.setRankVariation(by: rankVariation.0, with: rankVariation.1)
            
            if dailyBoxOffice.rank.rankOldAndNew == RankOldAndNew.new || dailyBoxOffice.rank.rankVariation == "0" {
                cell.boxOfficeRank.setRankVariation(by: nil, with: nil)
            } else {
                cell.boxOfficeRank.setRankVariation(by: rankImage.0, with: rankImage.1)
            }
            
            cell.boxOfficeRank.setRank(by: dailyBoxOffice.rank.rank)
            
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }
    }
}

//MARK: - Method
extension HomeViewController {
    private func determineRankVariation(with rankVariation: String, and rankOldAndNew: RankOldAndNew) -> (String, UIColor) {
        let returnValue = "-"

        switch rankOldAndNew {
        case .new:
            return ("신작", UIColor.red)
        case .old :
            guard rankVariation == "0" else {
                return (rankVariation, UIColor.black)
            }
            return (returnValue, UIColor.black)
        }
    }

    private func determineVariationImage(with rankVariation: String) -> (UIImage, UIColor) {
        guard rankVariation.hasPrefix("-") else {
            return (UIImage(systemName: "arrowtriangle.up.fill") ?? UIImage(), UIColor.red)
        }
        return (UIImage(systemName: "arrowtriangle.down.fill") ?? UIImage(), UIColor.blue)
    }
    
    private func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String {
        guard let audienceCount = Int(audienceCount), let audienceAccumulated = Int(accumulated) else {
            return ""
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let audienceResult = numberFormatter.string(for: audienceCount),
                let audienceAccumulatedCount = numberFormatter.string(for: audienceAccumulated) else {
            return ""
        }
        
        return "오늘 \(audienceResult) / 총 \(audienceAccumulatedCount)"
    }
    
    private func receiveCurrentDate() -> String {
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = formatter.string(from: date)
        
        return currentDateString
    }
}
