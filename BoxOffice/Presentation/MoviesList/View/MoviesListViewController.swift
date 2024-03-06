import UIKit

final class MoviesListViewController: UIViewController {
    
    private let viewModel: MoviesListViewModel
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesListCell.self, forCellWithReuseIdentifier: String(describing: MoviesListCell.self))
        return collectionView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: MoviesListViewModel, isRefreshing: Bool = false) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        setupNavigationBar()
        bind()
        viewModel.viewDidLoad()
    }
}

extension MoviesListViewController {
    
    private func bind() {
        viewModel.movies.bind { [weak self] _ in
            self?.reload()
        }
        viewModel.errorMessage.bind { [weak self] errorMessage in
            self?.makeAlert(message: errorMessage, confirmAction: nil)
        }
        viewModel.isRefreshing.bind { [weak self] isRefreshing in
            if !isRefreshing {
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "\(DateFormatter.titleDateFormatter.string(from: Date().yesterday))"
    }
    
    private func setupRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        viewModel.refresh()
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviesListCell.self), for: indexPath) as? MoviesListCell else {
            fatalError("MoviesListCell 에러")
        }
        viewModel.nowCell.bind { cellInformation in
            cell.configure(with: cellInformation)
        }
        viewModel.loadCell(indexPath.row)
        
        cell.accessories = [.disclosureIndicator()]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies.value[indexPath.item]
        showMovieDetailScreen(for: selectedMovie)
    }
    
    func showMovieDetailScreen(for movie: MovieBoxOffice) {
        let movieDetailViewController = MovieDetailView(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func reload() {
        self.collectionView.reloadData()
    }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 80)
    }
}

extension MoviesListViewController {
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
