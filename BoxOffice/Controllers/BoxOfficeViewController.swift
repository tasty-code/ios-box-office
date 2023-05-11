//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - Private
    private let networkService = NetworkService()
    private var dailyBoxOffice: DailyBoxOfficeDTO?
    private var movieDetail: MovieDetailDTO?
    
    private var movieCollectionView: UICollectionView! = nil
    private var movieDataSource: UICollectionViewDiffableDataSource<Section, MovieDTO>! = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sample = DailyBoxOfficeEndPoint(date: "20220202")
        updateData(from: sample) {
            self.dailyBoxOffice = $0
            self.applyMovieDataSource()
        }
        
        setup()
    }
    
    // MARK: - Private function
    private func setup() {
        configureMovieCollectionView()
        configureMovieDataSource()
        configureUI()
    }
    
    private func configureMovieDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MovieDTO> { cell, indexPath, item in
            var config = cell.defaultContentConfiguration()
            config.text = item.name
            cell.contentConfiguration = config
        }
        
        movieDataSource = UICollectionViewDiffableDataSource<Section, MovieDTO>(collectionView: movieCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = self.movieCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        applyMovieDataSource()
    }
    
    private func configureUI() {
        view.addSubview(movieCollectionView)
    }
        
    private func configureMovieCollectionView() {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        if #available(iOS 14.5, *) {
            config.separatorConfiguration.bottomSeparatorVisibility = .hidden
            config.separatorConfiguration.topSeparatorVisibility = .visible
            config.separatorConfiguration.topSeparatorInsets = .init(top: 0, leading: -100, bottom: 0, trailing: -100)
        }
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        movieCollectionView = collectionView
    }
    
    private func updateData<T: APIRepresentable, E: EndPointProtocol>(from api: E, completion: @escaping (T?) -> Void) where E.DTO == T {
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
    
}

