//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    private var dataSource: UICollectionViewDataSource?

    private lazy var collectionView = BoxOfficeCollectionView(frame: .zero)
    private lazy var indicatorView = ActivityIndicatorView(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Date.yesterday.formatData(type: .title)
        configureHierarchy()
        configureDataSource()
        configureRefreshControl()
    }
    
    private func configureHierarchy() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        
        self.dataSource = BoxOfficeDataSource()
        collectionView.dataSource = dataSource
    }
}

extension BoxOfficeViewController {

    func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {
        // 네트워크로 데이터 불러오는 작업 수행
        collectionView.reloadData()

        DispatchQueue.main.async {
           self.collectionView.refreshControl?.endRefreshing()
        }
    }
}
