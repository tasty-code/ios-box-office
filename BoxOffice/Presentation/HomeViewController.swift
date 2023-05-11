//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class HomeViewController: UIViewController {

    //MARK: - Initializer

    init(networkService: NetworkService = NetworkService(),
         dailyBoxOfficeStorage: [DailyBoxOffice] = [DailyBoxOffice](),
         selector: Selector = Selector(),
         formatter: Formatter = Formatter()
    ) {
        self.networkService = networkService
        self.dailyBoxOfficeStorage = dailyBoxOfficeStorage
        self.selector = selector
        self.formatter = formatter
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.networkService = NetworkService()
        self.dailyBoxOfficeStorage = [DailyBoxOffice]()
        self.selector = Selector()
        self.formatter = Formatter()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOfNavigationBar()
        configureOfCollectionView()
        configureHierarchy()
        configureDataSource()
        fetchData()
    }

    //MARK: - Private Property
    
    private var networkService: NetworkService
    private var dailyBoxOfficeStorage: [DailyBoxOffice]
    private var selector: Decidable
    private var formatter: Convertible
    private var collectionView: UICollectionView
    
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl) , for: .valueChanged)

        return refreshControl
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
    
    private func configureOfNavigationBar() {
        navigationItem.title = formatter.receiveCurrentDate()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide

        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureOfCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = false
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.refreshControl = refresh
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
            let rankVariation = selector.determineRankVariation(with: dailyBoxOffice.rank.rankVariation, and: dailyBoxOffice.rank.rankOldAndNew)
            let rankImage = selector.determineVariationImage(with: dailyBoxOffice.rank.rankVariation)
            
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
