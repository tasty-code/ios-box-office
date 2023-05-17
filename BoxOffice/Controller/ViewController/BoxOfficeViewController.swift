//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    private var dataSource: UICollectionViewDataSource?
    private let presentationProvider = PresentationProvider()

    private var boxOffices: [BoxOfficeItem] {
        self.presentationProvider.getBoxOffices()
    }

    private lazy var collectionView = BoxOfficeCollectionView(frame: .zero)
    private lazy var indicatorView = ActivityIndicatorView(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = presentationProvider.getBoxOfficeDate()
        presentationProvider.loadBoxOffices()

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

        presentationProvider.boxOfficeCall = {
            let boxOfficeDataSource = BoxOfficeDataSource()
            boxOfficeDataSource.boxOffices = self.presentationProvider.getBoxOffices()
            self.dataSource = boxOfficeDataSource

            DispatchQueue.main.async {
                self.collectionView.dataSource = self.dataSource
                self.indicatorView.stopAnimating()
            }
        }
    }
}

extension BoxOfficeViewController {

    func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {

        self.presentationProvider.loadBoxOffices()
        self.collectionView.isScrollEnabled = false

        presentationProvider.boxOfficeCall = {
            let boxOfficeDataSource = BoxOfficeDataSource()
            boxOfficeDataSource.boxOffices = self.presentationProvider.getBoxOffices()
            self.dataSource = boxOfficeDataSource

            DispatchQueue.main.async {
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.isScrollEnabled = true
            }
        }
    }
}
