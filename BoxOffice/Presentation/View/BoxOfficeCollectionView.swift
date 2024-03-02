import UIKit

final class BoxOfficeCollectionView: UICollectionView {
  typealias MovieCell = BoxOfficeCollectionViewCell
  
  convenience init() {
    let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, environment in
      var config = UICollectionLayoutListConfiguration(appearance: .plain)
      config.showsSeparators = true
      return NSCollectionLayoutSection.list(using: config, layoutEnvironment: environment)
    }
    let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    self.init(frame: .zero, collectionViewLayout: layout)
    setCollectionViewCell()
  }
  
  private func setCollectionViewCell() {
    register(MovieCell.self, forCellWithReuseIdentifier: "\(MovieCell.self)")
  }
}
