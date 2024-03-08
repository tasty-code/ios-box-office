
import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private let boxOfficeUseCase: BoxOfficeUseCaseProtocol
    
    @SynchronizedLock private var movies = [BoxOfficeDisplayModel]()
    private var fetchTask: Task<Void, Never>?
    
    private var boxOfficeCollectionView: BoxOfficeCollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeDisplayModel>!
    private var cellRegistration: UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeDisplayModel>!
    
    init(boxOfficeUseCase: BoxOfficeUseCaseProtocol) {
        self.boxOfficeUseCase = boxOfficeUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    deinit {
        fetchTask?.cancel()
        print("\(Self.description()) \(#function)")
    }
}


// MARK: - 생명주기
extension BoxOfficeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        fetchBoxOfficeData()
    }
}


// MARK: - Setup UI
private extension BoxOfficeViewController {
    
    func setupUI() {
        setupBoxOfficeView()
        configureCellRegistration()
        configureNavigationBar()
        setupRefreshControl()
    }
    
    func configureNavigationBar() {
        navigationItem.title = Date().formattedDate(withFormat: "YYYY-MM-dd")
    }
    
    // 커스텀 뷰 설정
    func setupBoxOfficeView() {
        boxOfficeCollectionView = BoxOfficeCollectionView(frame: .zero)
        view.backgroundColor = boxOfficeCollectionView.backgroundColor
        view.addSubview(boxOfficeCollectionView)
        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boxOfficeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            boxOfficeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        configureCellRegistration()
    }
    
    // 셀 등록 설정 메서드
    func configureCellRegistration() {
        cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeDisplayModel> { (cell, indexPath, movie) in
            cell.accessories = [.disclosureIndicator()]
            cell.rankLabel.text = movie.rank
            cell.movieNameLabel.text = movie.movieName
            guard let rankIntensity = Int(movie.rankIntensity) else { return }
            cell.matchRankIntensity(of: movie.isNew, with: rankIntensity)
            cell.matchAudienceAccount(of: movie)
        }
    }
    
    // Refresh
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshBoxOfficeData), for: .valueChanged)
        boxOfficeCollectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshBoxOfficeData() {
        fetchBoxOfficeData()
    }
}


// MARK: - Fetch Data
private extension BoxOfficeViewController {
    
    func fetchBoxOfficeData() {
        fetchTask = Task {
            let result = await boxOfficeUseCase.fetchBoxOfficeData()
            handleFetchResult(result)
        }
    }
    
    @MainActor
    func handleFetchResult(_ result: Result<[BoxOfficeMovie], DomainError>) {
        boxOfficeCollectionView.refreshControl?.endRefreshing()
        switch result {
        case .success(let boxOfficeMovies):
            let displayMovies = mapEntityToDisplayModel(boxOfficeMovies)
            self.movies = displayMovies
            applySnapshot(movies: displayMovies, animatingDifferences: true)
        case .failure(let error):
            presentAlert(title: "네트워크 오류", message: "네트워크에 문제가 있습니다 \(error)", confirmTitle: "확인")
        }
    }
    
    func mapEntityToDisplayModel(_ boxOfficeMovies: [BoxOfficeMovie]) -> [BoxOfficeDisplayModel] {
        return boxOfficeMovies.map {
            BoxOfficeDisplayModel(
                rank: $0.rank,
                rankIntensity: $0.rankChange,
                isNew: $0.isNew,
                movieName: $0.name,
                audienceCount: $0.dalilyAudience,
                audienceAccount: $0.cumulateAudience)}
    }
}

// MARK: - Apply Diffable DataSource
private extension BoxOfficeViewController {
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeDisplayModel>(collectionView: boxOfficeCollectionView) {
            (collectionView, indexPath, movie) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: movie)
        }
        let loadingPlaceholder = [BoxOfficeDisplayModel.placeholder]
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeDisplayModel>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(loadingPlaceholder, toSection: .main)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    func applySnapshot(movies: [BoxOfficeDisplayModel], animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeDisplayModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
