import UIKit

class MoviesCollectionView: UIViewController {
    
    var viewModel = MoviesListViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesListCell.self, forCellWithReuseIdentifier: "MoviesListCell")
        return collectionView
    }()
    
    let refreshControl = UIRefreshControl()
    var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        setupNavigationBar()
        fetchData()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "\(DateFormatter.titleDateFormatter.string(from: Date().yesterday()))"
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        if !isRefreshing {
            isRefreshing = true
            fetchData()
        }
    }
    
    func fetchData() {
        viewModel.fetchData { [weak self] result in
            switch result {
            case .success(let movies):
                print("\(movies)")
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                    self?.isRefreshing = false
                    print("다시 갖고왔니?")
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    self?.isRefreshing = false
                }
            }
        }
    }
}

extension MoviesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCell", for: indexPath) as? MoviesListCell else {
            fatalError("MoviesListCell 에러")
        }
        let movie = viewModel.movies.value[indexPath.item]
        cell.configure(with: movie)
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
}

extension MoviesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 100)
    }
}
