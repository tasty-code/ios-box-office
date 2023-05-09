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
        initialSnapShot()
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
                testEntity.append(DailyBoxOffice(rankEmoji: UIImage(systemName: "heart.fill")!, movieBrief: MovieBrief(movieName: officeList.movieName, audienceCount: officeList.audienceCount), rank: Rank(rank: officeList.rank, movieType: officeList.rankVariation)))
            })
            applySnapshot(items: testEntity, section: Section.main)
        }
    }

    private func applySnapshot(items: [DailyBoxOffice], section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: section)
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

        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, DailyBoxOffice> { (cell, indexPath, dailyBoxOffice) in
            cell.boxOfficeBrief.setMovieName(by: dailyBoxOffice.movieBrief.movieName)
            cell.boxOfficeBrief.setAudienceCount(by: dailyBoxOffice.movieBrief.audienceCount)
            cell.boxOfficeRank.setRankVariation(by: dailyBoxOffice.rank.movieType)
            cell.boxOfficeRank.setRankVariation(by: dailyBoxOffice.rankEmoji)
            cell.boxOfficeRank.setRank(by: dailyBoxOffice.rank.rank)
            cell.boxOfficeRank.setRankVaritaion(by: .red)

            cell.reloadInputViews()
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }

    }

    func initialSnapShot() {

//        let testEntity = [
//            DailyBoxOffice(rankEmoji: UIImage(), movieBrief: MovieBrief(movieName: "경관의 피", audienceCount: "오늘 64,050 / 총 69,228"), rank: Rank(rank: "1", movieType: "신작")),
//            DailyBoxOffice(rankEmoji: UIImage(systemName: "heart.fill") ?? UIImage(), movieBrief: MovieBrief(movieName: "영화 2", audienceCount: "123"), rank: Rank(rank: "123", movieType: "456")),
//            DailyBoxOffice(rankEmoji: UIImage(systemName: "star.fill") ?? UIImage(), movieBrief: MovieBrief(movieName: "영화 3", audienceCount: "123"), rank: Rank(rank: "123", movieType: "456"))
//        ]

        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(testEntity)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
