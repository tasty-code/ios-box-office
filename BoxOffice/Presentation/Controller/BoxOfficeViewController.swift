
import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private let boxOfficeUseCase: BoxOfficeUseCaseProtocol
    
    @SynchronizedLock private var movies: [BoxOfficeDisplayModel] = []
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
        setupRefreshControl()
    }
}


// MARK: - Refresh
private extension BoxOfficeViewController {
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshBoxOfficeData), for: .valueChanged)
        boxOfficeCollectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshBoxOfficeData() {
        fetchBoxOfficeData()
    }
}


// MARK: - Setup UI
private extension BoxOfficeViewController {
    
    private func setupUI() {
        setupBoxOfficeView()
        configureCellRegistration()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Date().formattedDate(withFormat: "YYYY-MM-dd")
    }
    
    // 커스텀 뷰 설정
    private func setupBoxOfficeView() {
        boxOfficeCollectionView = BoxOfficeCollectionView(frame: .zero)
        view.backgroundColor = boxOfficeCollectionView.backgroundColor
        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boxOfficeCollectionView)
        
        NSLayoutConstraint.activate([
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boxOfficeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            boxOfficeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        configureCellRegistration()
    }

    // 셀 등록 설정 메서드
    private func configureCellRegistration() {
        cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeDisplayModel> { (cell, indexPath, movie) in
            cell.accessories = [.disclosureIndicator()]
            cell.rankLabel.text = movie.rank
            cell.movieNameLabel.text = movie.movieName
            guard let rankIntensity = Int(movie.rankIntensity) else { return }
            cell.matchRankIntensity(of: movie.isNew, with: rankIntensity)
            cell.matchAudienceAccount(of: movie)
        }
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
    
    func handleFetchResult(_ result: Result<[BoxOfficeMovie], DomainError>) {
        boxOfficeCollectionView.refreshControl?.endRefreshing()
        switch result {
        case .success(let boxOfficeMovies):
            let displayMovies = mapEntityToDisplayModel(boxOfficeMovies)
            self.movies = displayMovies
            applySnapshot(movies: displayMovies, animatingDifferences: true)
        case .failure(let error):
            print("Failed to load data: \(error)")
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


// MARK: - Update UI
private extension BoxOfficeViewController {
    // 결과에 따라 UI 업데이트
    private func updateUI(with result: Result<[BoxOfficeDisplayModel], DomainError>, isLoading: Bool = false) {
        switch result {
        case .success(let movies):
            self.movies = movies
            applySnapshot(movies: movies, animatingDifferences: true)
        case .failure(let error):
            print("Failed to load data: \(error)")
        }
    }
}


// MARK: - Apply Diffable DataSource
private extension BoxOfficeViewController {
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeDisplayModel>(collectionView: boxOfficeCollectionView) {
            (collectionView, indexPath, movie) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: movie)
        }
        let loadingPlaceholder = (1...10).map { _ in BoxOfficeDisplayModel.placeholder }
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeDisplayModel>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(loadingPlaceholder, toSection: .main)
        dataSource.apply(initialSnapshot, animatingDifferences: false) // 초기 스냅샷 적용
    }
    
    private func applySnapshot(movies: [BoxOfficeDisplayModel], animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeDisplayModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
