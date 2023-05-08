//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfMainViewLayout()
        configureDataSource()
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
}

//MARK: - Configure of CollectionViewLayout
extension HomeViewController {
    private func configureOfMainViewLayout() {
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
            cell.dailyBoxOffice = dailyBoxOffice
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, dailyBoxOffice) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dailyBoxOffice)
        }
    }
}
