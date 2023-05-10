//
//  MovieViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class MovieViewController: UIViewController {

    let refreshControl = UIRefreshControl()
    var movieArrays: [Movie] = []
    var searchDate: String = "" {
        willSet {
            title = DateFormatter().movieDateFormatter(date: newValue)
        }
    }

    var collectionView: UICollectionView?
    var loadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .gray
        indicatorView.style = .large
        return indicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        searchDate = "20230509"
        loadMovie(for: searchDate)
    }

    @objc func refresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
        }
    }

    private func loadMovie(for date: String) {
        do {
            let api = URLPath.dailyBoxOffice(date: date)
            let url = try api.configureURL()
            let urlRequest = URLRequest(url: url)

            Networking().loadData(api.convertType, request: urlRequest) { [weak self] data, error in
                guard error == nil else {
                    print(error as Any)
                    return
                }

                guard let data = data else {
                    print("빈 데이터입니다")
                    return
                }
                self?.movieArrays = (data as! DailyBoxOffice).movies
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.stopAnimating()
                    self?.collectionView?.reloadData()
                }
            }
        } catch {
            print(error)
        }
    }
}

//MARK: - setup
extension MovieViewController {
    private func setup() {
        makeUI()
        setupCollectionView()
        setupLoadingIndicatorView()
        setupRefreshControl()
        registerCollectionViewCell()
    }

    private func makeUI() {
        view.backgroundColor = .white
        title = DateFormatter().movieDateFormatter(date: searchDate)
    }

    private func setupCollectionView() {
        let layoutconfig = UICollectionLayoutListConfiguration(appearance: .plain)
        let flowLayout = UICollectionViewCompositionalLayout.list(using: layoutconfig)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        guard let collectionView = collectionView else { return }

        view.addSubview(collectionView)
        collectionView.dataSource = self

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func setupLoadingIndicatorView() {
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func setupRefreshControl() {
        collectionView?.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    private func registerCollectionViewCell() {
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
    }
}

//MARK: - CollectionView DataSource
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArrays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        cell.configure(with: movieArrays[indexPath.row])
        return cell
    }
}

private extension DateFormatter {
    func movieDateFormatter(date: String) -> String {
        self.dateFormat = "yyyyMMdd"
        guard let convertDate = self.date(from: date) else {
            return date
        }

        self.dateFormat = "yyyy-MM-dd"
        return self.string(from: convertDate)
    }
}
