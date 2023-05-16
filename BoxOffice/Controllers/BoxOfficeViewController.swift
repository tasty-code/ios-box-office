//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

fileprivate enum Section {
    
    case main
    
}

final class BoxOfficeViewController: UIViewController {
    
    // MARK: - Private
    
    private let networkService = NetworkService()   
    private var dailyBoxOffice: DailyBoxOfficeDTO? {
        didSet {
            removeLoadLabel()
        }
    }
    private var movieDetail: MovieDetailDTO?
    private var movieCollectionView: UICollectionView!
    private var movieDataSource: UICollectionViewDiffableDataSource<Section, MovieDTO>!
    
    private let loadLabel: UILabel = {
        let label = UILabel()
        label.text = "loading..."
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateYesterdayData()
    }
    
    // MARK: - Private function
    
    private func removeLoadLabel() {
        DispatchQueue.main.async {
            self.loadLabel.removeFromSuperview()
        }
    }
    
    private func setup() {
        updateNavigationTitle()
        configureMovieCollectionView()
        configureMovieDataSource()
        configureRefreshControl()
        configureUI()
        animateLoadLabel()
    }
    
    private func updateNavigationTitle() {
        let yesterday = Date.yesterday
        let yesterdayString = yesterday.string(format: .yyyy_MM_dd)
        self.navigationController?.navigationBar.topItem?.title = yesterdayString
    }
    
    private func configureMovieCollectionView() {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        if #available(iOS 14.5, *) {
            config.separatorConfiguration.bottomSeparatorVisibility = .hidden
            config.separatorConfiguration.topSeparatorVisibility = .visible
            config.separatorConfiguration.topSeparatorInsets = .init(top: 0, leading: -100, bottom: 0, trailing: -100)
        }
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        movieCollectionView = collectionView
    }
    
    private func configureMovieDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MovieCollectionViewListCell, MovieDTO> { _, _, _ in }
        
        movieDataSource = UICollectionViewDiffableDataSource<Section, MovieDTO>(collectionView: movieCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = self.movieCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.update(movie: itemIdentifier)
            return cell
        }
        
        applyMovieDataSource()
    }
    
    private func configureRefreshControl() {
        let refreshControl: UIRefreshControl = {
            let control = UIRefreshControl()
            
            return control
        }()
        
        movieCollectionView.addSubview(refreshControl)
        movieCollectionView.refreshControl = refreshControl
        movieCollectionView.refreshControl?.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
    }
    
    @objc
    private func refreshCollectionView() {
        if movieCollectionView.refreshControl?.isRefreshing != false {
            movieCollectionView.refreshControl?.endRefreshing()
        }
        updateYesterdayData()
    }
    
    private func configureUI() {
        view.addSubview(movieCollectionView)
        
        view.addSubview(loadLabel)
        loadLabel.translatesAutoresizingMaskIntoConstraints = false
        loadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func updateYesterdayData() {
        let yesterday = Date.yesterday
        let yesterdayString = yesterday.string(format: .yyyyMMdd)
        
        let sample = DailyBoxOfficeEndPoint(date: yesterdayString)
        updateData(from: sample) {
            self.dailyBoxOffice = $0
            DispatchQueue.main.async {
                self.applyMovieDataSource()
            }
        }
    }
    
    private func updateData<E: EndPointProtocol>(from api: E, completion: @escaping (E.DTO?) -> Void)  {
        networkService.fetchData(endPoint: api) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    private func applyMovieDataSource() {
        let movies = dailyBoxOffice?.boxOfficeResult.dailyBoxOfficeList
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieDTO>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies ?? [])
        movieDataSource.apply(snapshot)
    }
    
    private func animateLoadLabel() {
        let opacityKeyframe = CAKeyframeAnimation(keyPath: "opacity")
        opacityKeyframe.values = [0.2, 0.5, 0.8, 0.5, 0.2]
        opacityKeyframe.keyTimes = [0, 0.3, 0.5, 0.8, 1]
        opacityKeyframe.duration = 0.8
        opacityKeyframe.repeatCount = .infinity
        loadLabel.layer.add(opacityKeyframe, forKey: "loading")
    }
    
}

fileprivate extension Date {
    
    enum DateFormat: String {
        case yyyy_MM_dd = "yyyy-MM-dd"
        case yyyyMMdd = "yyyyMMdd"
    }
    
    static var yesterday: Date {
        return Date(timeIntervalSinceNow: -24 * 60 * 60)
    }
    
    func string(format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        return formatter.string(from: self)
    }

}

