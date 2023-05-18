//
//  BoxOfficeDataSource.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/10.
//

import UIKit

final class BoxOfficeDataSource: NSObject, UICollectionViewDataSource {

    private var boxOffices: [BoxOfficeItem] = []
    
    init(boxOffices: [BoxOfficeItem]) {
        self.boxOffices = boxOffices
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        boxOffices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeue(cell: CustomListCell.self, for: indexPath)
        cell.boxOfficeItem = boxOffices[indexPath.item]
        
        return cell
    }
}
