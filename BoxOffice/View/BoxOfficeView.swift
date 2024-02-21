//
//  BoxOfficeView.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/21/24.
//

import UIKit

class BoxOfficeView: UIView {
    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "20240220")
        navigationBar.pushItem(navigationItem, animated: true)
        return navigationBar
    }()
    
    lazy var boxOfficeCollectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let boxOfficeCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        return boxOfficeCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeView {
    private func setupSubview() {
        addSubview(navigationBar)
        addSubview(boxOfficeCollectionView)
    }
    
    private func setupConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            boxOfficeCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            boxOfficeCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
