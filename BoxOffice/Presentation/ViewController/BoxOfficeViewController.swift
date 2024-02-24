import UIKit

final class BoxOfficeViewController: UIViewController {
  private let boxOfficeCollectionView: BoxOfficeCollectionView = BoxOfficeCollectionView()
  
  private lazy var boxOfficeListDataSource: BoxOfficeListDataSource = BoxOfficeListDataSource(self.boxOfficeCollectionView)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    self.title = "2021-02-24"
    setLayout()
    sendSnapshotToDiffable()
  }
  
  private func setLayout() {
    self.boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(boxOfficeCollectionView)
    
    NSLayoutConstraint.activate(
      [
        self.boxOfficeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        self.boxOfficeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        self.boxOfficeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        self.boxOfficeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ]
    )
  }
  
  func sendSnapshotToDiffable() {
    var snapshot = BoxOfficeListSnapShot()
    snapshot.appendSections([.movie])
    let items: [DailyBoxOffice.ListItem] = [
      .init(index: "1", rank: 1, rankChange: .fallen(3), title: "경관의 피", todayAudienceCount: 10000, totalAudienceCount: 20000, entryStatus: .old)
    ]
    let list = items.map(BoxOfficeListItem.movie)
    snapshot.appendItems(list, toSection: .movie)
    self.boxOfficeListDataSource.apply(snapshot)
  }
  
}
