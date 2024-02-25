//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let movieManager: MovieManager
    private let boxOfficeListView: BoxOfficeListView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let view = BoxOfficeListView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private lazy var dataSource = BoxOfficeListDataSource(self.boxOfficeListView)
    
    init(movieManager: MovieManager) {
        self.movieManager = movieManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeListView.boxOfficeListDelegate = self
        boxOfficeListView.dataSource = dataSource
        view = boxOfficeListView
        setupBoxOfficeData()
    }
}

private extension BoxOfficeViewController {
    func configureNavigation(date: Date) {
        self.title = date.toString(format: "yyyy-MM-dd")
    }
    
    func setupBoxOfficeData() {
        self.movieManager.fetchBoxOfficeResultData(date: yesterday.toString(format: "yyyyMMdd")) { [weak self] result in
            switch result {
            case .success(let success):
                self?.reloadCollectionListData(result: success)
            case .failure(let failure):
                print("fetchBoxOfficeResultData 실패: \(failure)")
            }
        }
    }
    
    func applyBoxOfficeList(result: BoxOfficeResult) {
        var boxOfficeListSnapShot = BoxOfficeListSnapShot()
        boxOfficeListSnapShot.appendSections([.movie])
        let movies = result.dailyBoxOfficeList
        boxOfficeListSnapShot.appendItems(movies, toSection: .movie)
        dataSource.apply(boxOfficeListSnapShot)
    }
    
    func updateBoxOfficeList() {
        movieManager.fetchBoxOfficeResultData(date: yesterday.toString(format: "yyyyMMdd")) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.applyBoxOfficeList(result: success)
                    guard
                        let date = success.showRange.toDate()
                    else {
                        return
                    }
                    self?.configureNavigation(date: date)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension BoxOfficeViewController: BoxOfficeListViewDelegate, DateHandlerable {
    func applyBoxOfficeListView() {
        DispatchQueue.main.async {
            self.updateBoxOfficeList()
        }
    }
    
    func reloadCollectionListData(result: BoxOfficeResult) {
        DispatchQueue.main.async {
            self.boxOfficeListView.indicatorView.stopAnimating()
            self.configureNavigation(date: self.yesterday)
            self.applyBoxOfficeList(result: result)
            self.boxOfficeListView.isScrollEnabled = true
        }
    }
}

