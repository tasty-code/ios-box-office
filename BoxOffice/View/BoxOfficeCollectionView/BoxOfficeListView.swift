//
//  BoxOfficeListView.swift
//  BoxOffice
//
//  Created by Matthew on 2/21/24.
//

import UIKit

final class BoxOfficeListView: UICollectionView {
    weak var boxOfficeListDelegate: BoxOfficeListViewDelegate?
    private lazy var refresher: UIRefreshControl = {
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
        collectionViewRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BoxOfficeListView {
    func collectionViewRegister() {
        self.register(
            MovieCell.self,
            forCellWithReuseIdentifier: MovieCell.identifier
        )
        self.refreshControl = refresher
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.boxOfficeListDelegate?.applyBoxOfficeListView()
            self.refreshControl?.endRefreshing()
        }
    }
}
