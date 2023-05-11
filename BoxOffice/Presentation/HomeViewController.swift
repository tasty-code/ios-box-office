//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Initializer

    init(networkService: NetworkService, testEntity: [DailyBoxOffice], decideHelper: Selector) {
        self.networkService = NetworkService()
        self.dailyBoxOfficeStorage = [DailyBoxOffice]()
        self.decideHelper = Selector()
        self.formatter = Formatter()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.networkService = NetworkService()
        self.dailyBoxOfficeStorage = [DailyBoxOffice]()
        self.decideHelper = Selector()
        self.formatter = Formatter()

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        fetchData()
    }

    //MARK: - Private Property
    
    private var networkService: NetworkService
    private var dailyBoxOfficeStorage: [DailyBoxOffice]
    private var decideHelper: Decidable
    private var formatter: Convertible

    private lazy var navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: formatter.receiveCurrentDate())
        navigationBar.setItems([navigationItem], animated: true)
        navigationBar.isTranslucent = false

        return navigationBar
    }()
    
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl) , for: .valueChanged)

        return refreshControl
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: createCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        collectionView.refreshControl = refresh

        return collectionView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!

}

//MARK: - Private Method
extension HomeViewController {
    
    private func fetchData() {
        let yesterdayDate = formatter.receiveCurrentDate().split(separator: "-").joined()
        let boxOfficeQueryParameters = BoxOfficeQueryParameters(targetDate: yesterdayDate)

        Task {
            let result = try await networkService.request(with: APIEndPoint.receiveBoxOffice(with: boxOfficeQueryParameters))
            
            result.boxOfficeResult.dailyBoxOfficeList.forEach({ officeList in
                dailyBoxOfficeStorage.append(DailyBoxOffice(movieBrief: MovieBrief(movieName: officeList.movieName, audienceCount: officeList.audienceCount, audienceAccumulated: officeList.audienceAccumulate), rank: Rank(rank: officeList.rank, rankVariation: officeList.rankVariation, rankOldAndNew: officeList.rankOldAndNew)))
            })
            applySnapshot()
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dailyBoxOfficeStorage)
        dataSource.apply(snapshot)
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refresh.endRefreshing()
        }
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

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let configure = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
        return layout
    }
}

//MARK: - Configure of DiffableDataSource
extension HomeViewController {
    
    private func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOffice> { [self] (cell, indexPath, dailyBoxOffice) in
            let rankVariation = decideHelper.determineRankVariation(with: dailyBoxOffice.rank.rankVariation, and: dailyBoxOffice.rank.rankOldAndNew)
            let rankImage = decideHelper.determineVariationImage(with: dailyBoxOffice.rank.rankVariation)
            
            cell.summaryInformationView.setMovieName(by: dailyBoxOffice.movieBrief.movieName)
            cell.summaryInformationView.setAudienceCount(by: formatter.convertToNumberFormatter(dailyBoxOffice.movieBrief.audienceCount,
                                                                                   accumulated: dailyBoxOffice.movieBrief.audienceAccumulated))
            cell.rankView.setRankVariation(by: rankVariation.0, with: rankVariation.1)
            
            if dailyBoxOffice.rank.rankOldAndNew == RankOldAndNew.new || dailyBoxOffice.rank.rankVariation == MagicLiteral.zero {
                cell.rankView.setRankVariation(by: nil, with: nil)
            } else {
                cell.rankView.setRankVariation(by: rankImage.0, with: rankImage.1)
            }
            
            cell.rankView.setRank(by: dailyBoxOffice.rank.rank)
            
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }
    }
}
