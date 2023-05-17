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

        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: .transformedBoxOfficeData, object: nil)
        configureUIComponents()
        configureHierarchy()
        configureDataSource()
    }
    
    //MARK: - Private Property
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 100)))
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOffice>!
    
    private let boxOfficeViewModel = BoxOfficeViewModel()
    
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl) , for: .valueChanged)

        return refreshControl
    }()

}

//MARK: - Private Method
extension HomeViewController {

    @objc private func receiveNotification(notification: Notification) {
        guard let receivedData = notification.userInfo?["transformedBoxOfficeData"] as? [DailyBoxOffice] else { return }

        applySnapshot(with: receivedData)
    }
    
    private func checkOfAnimatingActivityIndicator(isAnimated: Bool) {
        guard isAnimated != activityIndicator.isAnimating else { return }
                
        if isAnimated {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    private func applySnapshot(with dailyBoxOfficeStorage: [DailyBoxOffice]) {
        var snapshot = dataSource.snapshot()
        
        let previousItems = snapshot.itemIdentifiers(inSection: .main)
        snapshot.deleteItems(previousItems)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.checkOfAnimatingActivityIndicator(isAnimated: false)

            snapshot.appendItems(dailyBoxOfficeStorage)
            self.dataSource.apply(snapshot)
        })
    }

    @objc func handleRefreshControl() {
        self.boxOfficeViewModel.transformIntoDailyBoxOffice()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refresh.endRefreshing()
        }
    }
}

//MARK: - Configure of UIComponents
extension HomeViewController {
    
    private func configureUIComponents() {
        configureSuperView()
        configureOfNavigationBar()
        configureOfActivityIndicator()
        configureOfCollectionView()
        
        checkOfAnimatingActivityIndicator(isAnimated: true)
    }
    
    private func configureSuperView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureOfNavigationBar() {
        navigationItem.title = Getter.receiveCurrentDate
    }
    
    private func configureOfActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.color = .darkGray
        activityIndicator.style = .large
        activityIndicator.isHidden = false
    }
    
    private func configureOfCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.isPrefetchingEnabled = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.refreshControl = refresh
    }
}


//MARK: - Configure of CollectionViewLayout
extension HomeViewController {
    
    private func configureHierarchy() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
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
        
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeListCell, DailyBoxOffice> { (cell, _, dailyBoxOffice) in
            cell.configureOfCellRegistration(with: dailyBoxOffice)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems([])
        
        dataSource.apply(snapshot)
        
        self.boxOfficeViewModel.transformIntoDailyBoxOffice()
    }
}
