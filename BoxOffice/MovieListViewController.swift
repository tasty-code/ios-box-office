//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//
import OSLog
import UIKit

final class MovieListViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    private var dailyBoxOfficeList:[DailyBoxOfficeDTO.BoxOfficeDTO.MovieInfo] = []
    private let apiBuilder = APIURLBuilder()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let CV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return CV
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Date().yesterday(format: Date.yyyyMMddHyphen)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionView()
        view.addSubview(activityIndicator)
        loadData()
    }
    
    @objc
    private func loadData() {
        Task {
            let data = try await networkManager.performRequest(with: apiBuilder.buildDailyBoxOfficeAPI(targetDate: APIURLCompnents.QueryValues.targetDate))
            
            guard let parsedData = JSONParser().decode(data, DTO: DailyBoxOfficeDTO.self),
                  let dailyBoxOfficeData = parsedData.boxOfficeResult.dailyBoxOfficeList
            else {
                return
            }
            dailyBoxOfficeList = dailyBoxOfficeData
            collectionView.reloadData()
            activityIndicator.removeFromSuperview()
            refreshControl.endRefreshing()
        }
    }

    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell else {
            fatalError("fatalError")
        }
        cell.configureCell(with: dailyBoxOfficeList[indexPath.row])
        cell.addSubview(MovieListCollectionViewCell())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                    dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
