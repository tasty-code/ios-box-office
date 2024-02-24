import UIKit

enum BoxOfficeListSection {
  case movie
}

enum BoxOfficeListItem: Hashable {
  case movie(DailyBoxOffice.ListItem)
}

typealias BoxOfficeListSnapShot = NSDiffableDataSourceSnapshot<BoxOfficeListSection, BoxOfficeListItem>

final class BoxOfficeListDataSource: UICollectionViewDiffableDataSource<BoxOfficeListSection, BoxOfficeListItem> {
  typealias CollectionView = BoxOfficeCollectionView
  typealias MovieCell = BoxOfficeCollectionViewCell
  
  static let cellProvider: CellProvider = { collectionView, indexPath, itemIdentifier in
    switch itemIdentifier {
    case .movie(let item):
      guard
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "\(MovieCell.self)", for: indexPath
        ) as? MovieCell
      else { return MovieCell() }
      cell.configure(with: item)
      return cell
    }
  }
  
  convenience init(_ collectionView: CollectionView) {
    self.init(collectionView: collectionView, cellProvider: Self.cellProvider)
  }
}
