//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOfNavigationBar()
        configureOfCollectionView()
        configureHierarchy()
        
        configureDataSource()
        applySnapshot()
    }
    
    //MARK: - Private Property
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!
    
    private let selector: Selector = Selector()
    private let viewModel = BoxOfficeViewModel()
    
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl) , for: .valueChanged)

        return refreshControl
    }()

}

//MARK: - Private Method
extension HomeViewController {

    private func applySnapshot() {
        var snapshot = dataSource.snapshot()
        
            let previousItems = snapshot.itemIdentifiers(inSection: .main)
        snapshot.deleteItems(previousItems)
        
        self.viewModel.transformIntoDailyBoxOffice { dailyBoxOfficeStorage in
            DispatchQueue.main.async {
                snapshot.appendItems(dailyBoxOfficeStorage)
                self.dataSource.apply(snapshot)
            }
        }
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
        navigationItem.title = Formatter.receiveCurrentDate
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
            let rankVariationColor = selector.determineRankVariationColor(with: dailyBoxOffice.rank.rankOldAndNew)
            let rankImage = selector.determineVariationImage(with: dailyBoxOffice.rank.rankVariation)
            let rankImageColor = selector.determineVariationImageColor(with: dailyBoxOffice.rank.rankVariation)
            
            cell.summaryInformationView.setMovieName(by: dailyBoxOffice.movieBrief.movieName)
            cell.summaryInformationView.setAudienceCount(by: Formatter().convertToNumberFormatter(dailyBoxOffice.movieBrief.audienceCount,
                                                                                                accumulated: dailyBoxOffice.movieBrief.audienceAccumulated))
            cell.rankView.setRankVariation(by: rankVariation)
            cell.rankView.setRankVariation(by: rankVariationColor)
            
            if dailyBoxOffice.rank.rankOldAndNew == RankOldAndNew.new || dailyBoxOffice.rank.rankVariation == MagicLiteral.zero {
                cell.rankView.setRankImage(by: UIImage())
                cell.rankView.setRankImage(by: .black)
            } else {
                cell.rankView.setRankImage(by: rankImage)
                cell.rankView.setRankImage(by: rankImageColor)
            }
            
            cell.rankView.setRank(by: dailyBoxOffice.rank.rank)
            
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems([])
        
        dataSource.apply(snapshot)
    }
}
