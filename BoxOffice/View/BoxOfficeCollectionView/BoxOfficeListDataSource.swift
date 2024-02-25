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

enum Item: Hashable {
    case movie(DailyBoxOfficeList)
}

typealias BoxOfficeListSnapShot = NSDiffableDataSourceSnapshot<MovieSection, Item>

final class BoxOfficeListDataSource: UICollectionViewDiffableDataSource<MovieSection, Item> {
    static let cellProvider: CellProvider = { collectionView, indexPath, itemIdentifier in
        switch itemIdentifier {
        case .movie(let movie):
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieCollectionCell.identifier,
                for: indexPath
            ) as? MovieCollectionCell
            else {
                return MovieCollectionCell()
            }
            cell.configure(result: movie)
            cell.accessories = [.disclosureIndicator()]
            return cell
        }
    }
    
    convenience init(_ collectionView: BoxOfficeListView) {
        self.init(collectionView: collectionView, cellProvider: Self.cellProvider)
    }
}
