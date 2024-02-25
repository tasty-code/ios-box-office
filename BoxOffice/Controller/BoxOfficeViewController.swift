//
//  ViewController.swift
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
        view = boxOfficeListView
        setupBoxOfficeData()
        configureNavigation()
    }
}

private extension BoxOfficeViewController {
    func configureNavigation() {
        guard
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        title = yesterday.toString(format: "yyyy-MM-dd")
    }
    
    func setupBoxOfficeData() {
        guard
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        self.movieManager.fetchBoxOfficeResultData(date: yesterday.toString(format: "yyyyMMdd")) { result in
            switch result {
            case .success(let success):
                self.reloadCollectionListData(result: success)
            case .failure(let failure):
                print("fetchBoxOfficeResultData 실패: \(failure)")
            }
        }
    }
    
    func applyBoxOfficeList() {
        var boxOfficeListSnapShot = BoxOfficeListSnapShot()
        boxOfficeListSnapShot.appendSections([.movie])
        movieManager.fetchBoxOfficeResultData(date: "20200101") { result in
            switch result {
            case .success(let success):
                let items = success.dailyBoxOfficeList.map(Item.movie)
                boxOfficeListSnapShot.appendItems(items, toSection: .movie)
                self.dataSource.apply(boxOfficeListSnapShot)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func test() {
        var boxOfficeListSnapShot = BoxOfficeListSnapShot()
        boxOfficeListSnapShot.appendSections([.movie])
        movieManager.fetchBoxOfficeResultData(date: "20200101") { result in
            switch result {
            case .success(let success):
                let items = success.dailyBoxOfficeList.map(Item.movie)
                boxOfficeListSnapShot.appendItems(items, toSection: .movie)
                self.dataSource.apply(boxOfficeListSnapShot)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
}

extension BoxOfficeViewController: BoxOfficeListViewDelegate {
    func applyBoxOfficeListView() {
        self.applyBoxOfficeList()
    }
    
    func reloadCollectionListData(result: [DailyBoxOfficeList]) {
        DispatchQueue.main.async {
            self.boxOfficeListView.indicatorView.stopAnimating()
            self.applyBoxOfficeList()
        }
    }
}
