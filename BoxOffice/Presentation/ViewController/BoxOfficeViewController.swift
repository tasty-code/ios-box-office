import UIKit

final class BoxOfficeViewController: UIViewController {
  private let boxOfficeCollectionView: BoxOfficeCollectionView = BoxOfficeCollectionView()
  
  private lazy var boxOfficeListDataSource: BoxOfficeListDataSource = BoxOfficeListDataSource(self.boxOfficeCollectionView)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    self.title = "2021-02-24"
    setLayout()
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
  
  
  
}
