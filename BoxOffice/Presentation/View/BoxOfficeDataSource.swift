import UIKit

enum BoxOfficeSection {
  case movie
}

enum BoxOfficeItem: Hashable {
  case movie(DailyBoxOffice.ListItem)
}

typealias BoxOfficeSnapShot = NSDiffableDataSourceSnapshot<BoxOfficeSection, BoxOfficeItem>

final class BoxOfficeDataSource: UICollectionViewDiffableDataSource<BoxOfficeSection, BoxOfficeItem> {
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
