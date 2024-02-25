//
//  BoxOfficeListView.swift
//  BoxOffice
//
//  Created by Matthew on 2/21/24.
//

import UIKit

protocol BoxOfficeListViewDelegate: AnyObject {
    func applyBoxOfficeListView()
}

final class BoxOfficeListView: UICollectionView {
    weak var boxOfficeListDelegate: BoxOfficeListViewDelegate?
    let indicatorView = UIActivityIndicatorView()
    private lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let action = UIAction { _ in
            self.refreshCollectionView()
        }
        refreshControl.addAction(action, for: .valueChanged)
        return refreshControl
    }()
    
    override init(
        frame: CGRect,
        collectionViewLayout layout: UICollectionViewLayout
    ) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupIndicatorView()
        collectionViewRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BoxOfficeListView {
    func collectionViewRegister() {
        self.register(
            MovieCollectionCell.self,
            forCellWithReuseIdentifier: MovieCollectionCell.identifier
        )
        self.refreshControl = refresh
    }
    
    func setupIndicatorView() {
        self.backgroundView = indicatorView
        indicatorView.startAnimating()
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.boxOfficeListDelegate?.applyBoxOfficeListView()
            self.refreshControl?.endRefreshing()
        }
    }
}
