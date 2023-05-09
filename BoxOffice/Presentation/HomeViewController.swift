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

    private let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "2023-05-01")
        navigationBar.setItems([navigationItem], animated: true)

        return navigationBar
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: configureOfCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .systemGray2

        return collectionView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!

    private func fetchData() {
        let boxOfficeRequestDTO = BoxOfficeRequestDTO(targetDate: "20230507")

        var networkResult: BoxOfficeResult?

        Task {
            let result = try await networkService.request(with: APIEndPoint.receiveBoxOffice(with: boxOfficeRequestDTO))
            networkResult = result.boxOfficeResult
            networkResult?.dailyBoxOfficeList.forEach({ officeList in
                testEntity.append(DailyBoxOffice(rankEmoji: UIImage(systemName: "heart.fill")!, movieBrief: MovieBrief(movieName: officeList.movieName, audienceCount: officeList.audienceCount, audienceAccumulated: officeList.audienceAccumulate), rank: Rank(rank: officeList.rank, movieType: officeList.rankVariation)))
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

        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOffice> { (cell, indexPath, dailyBoxOffice) in
            cell.boxOfficeBrief.setMovieName(by: dailyBoxOffice.movieBrief.movieName)
            cell.boxOfficeBrief.setAudienceCount(by: self.convertToNumberFormatter(dailyBoxOffice.movieBrief.audienceCount,
                                                                                   accumulated: dailyBoxOffice.movieBrief.audienceAccumulated))
            cell.boxOfficeRank.setRankVariation(by: dailyBoxOffice.rank.movieType)
            cell.boxOfficeRank.setRankVariation(by: dailyBoxOffice.rankEmoji)
            cell.boxOfficeRank.setRank(by: dailyBoxOffice.rank.rank)
            cell.boxOfficeRank.setRankVaritaion(by: .red)
            
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }
    }
    
    func convertToNumberFormatter(_ audienceCount: String, accumulated: String) -> String {
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
}
