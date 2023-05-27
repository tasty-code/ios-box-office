//
//  MovieViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class MovieViewController: UIViewController {

    private var movieArrays: [Movie] = []
    private var searchDate: String = "" {
        willSet {
            title = DateFormatter().movieDateFormatter(date: newValue)
            loadingIndicatorView.startAnimating()
            loadMovie(for: newValue)
        }
    }

    private lazy var collectionView: UICollectionView = {
        let layoutconfig = UICollectionLayoutListConfiguration(appearance: .plain)
        let flowLayout = UICollectionViewCompositionalLayout.list(using: layoutconfig)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .gray
        indicatorView.style = .large
        indicatorView.center = view.center
        indicatorView.startAnimating()
        return indicatorView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc private func refresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
        }
    }

    @objc private func loadCalendar() {
        let nextVC = CalanderViewController()
        nextVC.delegate = self
        present(nextVC, animated: true)
    }

    private func loadMovie(for date: String) {
        let api = EndPoint.dailyBoxOffice(date: date)

        Networking().loadData(from: api) { [weak self] data, error in
            if let error = error {
                print(error)
            }

            if let data = data {
                self?.movieArrays = (data as! DailyBoxOffice).movies
            } else {
                print("빈 데이터입니다")
            }

            DispatchQueue.main.async {
                self?.loadingIndicatorView.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: - setup
extension MovieViewController {
    private func setup() {
        setUI()
        addSubviews()
        setLayout()
    }

    private func setUI() {
        view.backgroundColor = .white
        title = DateFormatter().movieDateFormatter(date: searchDate)

        let button = UIBarButtonItem(title: "날짜 선택", style: .plain, target: self, action: #selector(loadCalendar))
        navigationItem.rightBarButtonItem = button

        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        searchDate = DateFormatter().movieDateFormatter(date: yesterday)
    }

    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(loadingIndicatorView)
        
    }

    private func setLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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

extension DateFormatter {
    func movieDateFormatter(date: String) -> String {
        self.dateFormat = "yyyyMMdd"
        guard let convertDate = self.date(from: date) else {
            return date
        }

        self.dateFormat = "yyyy-MM-dd"
        return self.string(from: convertDate)
    }

    func movieDateFormatter(date: Date) -> String {
        self.dateFormat = "yyyyMMdd"
        return self.string(from: date)
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieArrays[indexPath.row]
        let nextVC = MovieDetailViewController()
        nextVC.movie = movie
        show(nextVC, sender: nil)
    }
}

extension MovieViewController: CalanderDelegate {
    func selectedDate(date: Date) {
        searchDate = DateFormatter().movieDateFormatter(date: date)
    }
}
