//
//  BoxOfficeListView.swift
//  BoxOffice
//
//  Created by Matthew on 2/21/24.
//

import UIKit

class BoxOfficeListView: UIView {
    
    let collectionView: UICollectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeListView {
    func addSubview() {
        addSubview(collectionView)
    }
    
    func setupConstants() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
