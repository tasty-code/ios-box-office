//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Private Property
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        
        //TODO: - Register of CollectionViewCell
        
        configureOfMainViewLayout()
        
        return collectionView
    }()
    
    //MARK: - Private Method
    private func configureOfMainViewLayout() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
