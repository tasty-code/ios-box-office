//
//  BoxOfficeView.swift
//  BoxOffice
//
//  Created by Kim EenSung on 2/21/24.
//

import UIKit

protocol BoxOfficeCollectionViewDelegate: AnyObject {
    func loadDailyBoxOfficeData() async
}

final class BoxOfficeView: UIView {
    weak var delegate: BoxOfficeCollectionViewDelegate?
    
    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: Date.yesterday.formatted(using: .standard))
        navigationBar.isTranslucent = false
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
    func configureRefreshControl(_ viewController: BoxOfficeViewController) {
        boxOfficeCollectionView.refreshControl = UIRefreshControl()
        boxOfficeCollectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        Task {
            await delegate?.loadDailyBoxOfficeData()
            DispatchQueue.main.async {
                self.boxOfficeCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func reloadData() {
        boxOfficeCollectionView.reloadData()
    }
}

extension BoxOfficeView {
    func setBoxOfficeCollectionViewDelegate(_ viewController: BoxOfficeViewController) {
        boxOfficeCollectionView.dataSource = viewController
        boxOfficeCollectionView.delegate = viewController
    }
    
    func setBoxOfficeCollectionViewProperties(loadingIndicatorView: UIActivityIndicatorView) {
        boxOfficeCollectionView.backgroundView = loadingIndicatorView
        boxOfficeCollectionView.isScrollEnabled = false
        boxOfficeCollectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.className)
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
