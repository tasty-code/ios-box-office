//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {

    private enum Section {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>

    private let loadingIndicatorView = UIActivityIndicatorView(style: .large)
    private let boxOfficeManager = NetworkAPIManager()
    private var dataSource: DataSource?
    private lazy var dailyBoxOfficeCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    private var movies = [DailyBoxOffice]() {
        didSet {
            applySnapShot()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureCollectionView()
        configureDataSource()
        addIndicatorview()
        fetchBoxOfficeData()
    }

    private func setUpUI() {
        view.backgroundColor = .systemBackground
    }

    private func configureCollectionView() {
        view.addSubview(dailyBoxOfficeCollectionView)
        dailyBoxOfficeCollectionView.delegate = self
        dailyBoxOfficeCollectionView.register(
            DailyBoxOfficeCell.self,
            forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
        configureCollectionViewLayoutConstraint()
        configureRefreshControl()
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)

            return NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment)
        }

        return layout
    }

    private func configureCollectionViewLayoutConstraint() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        dailyBoxOfficeCollectionView.leadingAnchor.constraint(
            equalTo: safeAreaGuide.leadingAnchor).isActive = true
        dailyBoxOfficeCollectionView.trailingAnchor.constraint(
            equalTo: safeAreaGuide.trailingAnchor).isActive = true
        dailyBoxOfficeCollectionView.bottomAnchor.constraint(
            equalTo: safeAreaGuide.bottomAnchor).isActive = true
        dailyBoxOfficeCollectionView.topAnchor.constraint(
            equalTo: safeAreaGuide.topAnchor).isActive = true
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: dailyBoxOfficeCollectionView)
        { collectionView, indexPath, movie in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyBoxOfficeCell.identifier,
                for: indexPath) as? DailyBoxOfficeCell
            
            cell?.accessories = [.disclosureIndicator()]
            cell?.configure(with: movie)

            return cell
        }
    }

    private func fetchBoxOfficeData() {
        let yesterDay = Date.yesterDayDateConvertToString()
        let yesterdayDashExcepted = yesterDay.without("-")
        let boxOfficeEndPoint = BoxOfficeAPIEndpoint.boxOffice(targetDate: yesterdayDashExcepted)

        Task{
            guard let decodedData = try await boxOfficeManager.fetchData(
                to: BoxOffice.self,
                endPoint: boxOfficeEndPoint)
            else {
                return
            }

            guard let boxOffice = decodedData as? BoxOffice else { return }
            movies = boxOffice.result.dailyBoxOffices
            self.navigationItem.title = yesterDay
            self.removeIndicatorView()
            self.endRefresh()
        }
    }


    private func applySnapShot() {
        var snapShot = SnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(movies)
        self.dataSource?.apply(snapShot)
    }

}

extension DailyBoxOfficeViewController {

    private func addIndicatorview() {
        loadingIndicatorView.frame = view.frame
        loadingIndicatorView.color = .systemBlue
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
    }
    
    private func removeIndicatorView() {
        loadingIndicatorView.removeFromSuperview()
    }

    private func configureRefreshControl() {
        dailyBoxOfficeCollectionView.refreshControl = UIRefreshControl()
        dailyBoxOfficeCollectionView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefreshControl),
            for: .valueChanged
        )
    }

    private func endRefresh() {
        dailyBoxOfficeCollectionView.refreshControl?.endRefreshing()
    }

    @objc private func handleRefreshControl() {
        fetchBoxOfficeData()
    }

}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource?.itemIdentifier(for: indexPath) else { return }
        let movieDetailViewController = MovieDetailViewController(
            movie: movie,
            BoxOfficeAPIManager: boxOfficeManager
        )
        movieDetailViewController.navigationItem.title = movie.movieName
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }

}
