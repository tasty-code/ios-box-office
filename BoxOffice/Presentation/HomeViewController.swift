//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "2023-05-01")
        navigationBar.setItems([navigationItem], animated: true)
        
        return navigationBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOfMainViewLayout()
    }
    
    //MARK: - Private Property
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        
        //TODO: - Register of CollectionViewCell
        
        return collectionView
    }()
    
    //MARK: - Private Method
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
}
