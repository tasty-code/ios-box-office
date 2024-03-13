import UIKit

final class BoxOfficeListViewController: UIViewController {
    private var movieAPIFetcher: MovieAPIFetcherProtocol
    private var dailyBoxOfficeList: [CustomDailyBoxOffice] = []
    private var movieListCollectionView: BoxOfficeListCollectionView?
    
    init(fetcher: MovieAPIFetcherProtocol) {
        self.movieAPIFetcher = fetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitle()
        setupCompositionalLayout()
        fetchDailyBoxOfficeList()
    }
}

extension BoxOfficeListViewController: BoxOfficeListDelegate {
    private func reloadMovieListCollectionView() {
        DispatchQueue.main.async {
            self.movieListCollectionView?.reloadData()
        }
    }
    
    func refreshBoxOfficeList() {
        self.movieListCollectionView?.toggleLoadingIndicator(shouldStart: true)
        movieAPIFetcher.fetchBoxOffice { [weak self] result in
            DispatchQueue.main.async {
                self?.movieListCollectionView?.toggleLoadingIndicator(shouldStart: false)
                self?.movieListCollectionView?.refreshControl?.endRefreshing()
            }
            switch result {
            case .success(let boxOfficeList):
                self?.dailyBoxOfficeList = boxOfficeList
                self?.reloadMovieListCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BoxOfficeListViewController {
    private func configureNavigationBarTitle() {
        navigationItem.title = Date.todayStringFormatter
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    private func fetchDailyBoxOfficeList() {
        movieAPIFetcher.fetchBoxOffice { [weak self] result in
            switch result {
            case .success(let boxOfficeList):
                self?.reloadMovieListCollectionView()
                self?.dailyBoxOfficeList = boxOfficeList
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BoxOfficeListViewController {
    private func setupCompositionalLayout() {
        movieListCollectionView = BoxOfficeListCollectionView(frame: .zero, collectionViewLayout: configuerCompositionalLayout())
        guard let movieListCollectionView = movieListCollectionView else { return }
        movieListCollectionView.setBoxOfficeDelegete(delegate: self)
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        view.addSubview(movieListCollectionView)
        movieListCollectionView.frame = view.bounds
    }
    
    private func configuerCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layout
    }
}

extension BoxOfficeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeListViewListCell.reuseIdentifier, for: indexPath) as? BoxOfficeListViewListCell else {
            fatalError("BoxOfficeListViewCell dequeueReusableCell Error ")
        }
        let boxOffice = dailyBoxOfficeList[indexPath.row]
        cell.configure(with: boxOffice)
        cell.accessories = [.disclosureIndicator()]
        return cell
    }
}





