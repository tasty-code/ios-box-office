//
//  BoxOfficeListDataSource.swift
//  BoxOffice
//
//  Created by 강창현 on 2/23/24.
//

import UIKit

enum MovieSection {
    case movie
}

typealias BoxOfficeListSnapShot = NSDiffableDataSourceSnapshot<MovieSection, DailyBoxOfficeList>

final class BoxOfficeListDataSource: UICollectionViewDiffableDataSource<MovieSection, DailyBoxOfficeList> {
    static let cellProvider: CellProvider = { collectionView, indexPath, movie in
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieCell.identifier,
                for: indexPath
            ) as? MovieCell
        else {
            return MovieCell()
        }
        cell.configure(result: movie)
        cell.accessories = [.disclosureIndicator()]
        return cell
    }
    
    convenience init(_ collectionView: BoxOfficeListView) {
        self.init(collectionView: collectionView, cellProvider: Self.cellProvider)
    }
}
