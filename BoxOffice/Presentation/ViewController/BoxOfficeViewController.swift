import UIKit

final class BoxOfficeViewController: UIViewController {
  private let viewModel: BoxOfficeInput
  
  private let boxOfficeCollectionView: BoxOfficeCollectionView = BoxOfficeCollectionView()
  
  private lazy var boxOfficeListDataSource: BoxOfficeListDataSource = BoxOfficeListDataSource(self.boxOfficeCollectionView)
  
  init(viewModel: BoxOfficeInput) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    setLayout()
    setRefreshControl()
    viewModel.viewDidLoad()
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
  
  private func setRefreshControl() {
    self.boxOfficeCollectionView.refreshControl = .init()
    let action = UIAction { _ in
      self.viewModel.pullToRefresh()
    }
    self.boxOfficeCollectionView.refreshControl?.addAction(action, for: .valueChanged)
  }
}

extension BoxOfficeViewController: BoxOfficeOutput {
  func updateTitle(with title: String?) {
    self.title = title
  }
  
  func updateBoxOffice(items: [DailyBoxOffice.ListItem]) {
    var snapshot = BoxOfficeListSnapShot()
    snapshot.appendSections([.movie])
    let list = items.map(BoxOfficeListItem.movie)
    snapshot.appendItems(list, toSection: .movie)
    Task {
      await MainActor.run {
        self.boxOfficeListDataSource.apply(snapshot)
        self.boxOfficeCollectionView.refreshControl?.endRefreshing()
      }
    }
  }
  
  func showError(message: String) {
    let alert = UIAlertController(
      title: "💩오류!💩",
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    Task {
      await MainActor.run {
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
}
