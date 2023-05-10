//
//  BoxOfficeDataSource.swift
//  BoxOffice
//
//  Created by Sunny on 2023/05/10.
//

import UIKit

final class BoxOfficeDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        BoxOfficeItem.mock.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "\(CustomListCell.self)"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CustomListCell else {
            return UICollectionViewCell()
        }
        
        cell.boxOfficeItem = BoxOfficeItem.mock[indexPath.item]
        
        return cell
    }
}
