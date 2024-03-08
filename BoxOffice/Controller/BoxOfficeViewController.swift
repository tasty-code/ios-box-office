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
        let configure = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
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
        boxOfficeListView.delegate = self
        boxOfficeListView.dataSource = dataSource
        view = boxOfficeListView
        setupBoxOfficeData()
    }
}

private extension BoxOfficeViewController {
    func configureNavigation(date: Date) {
        self.title = Date.titleDateFormatter.string(from: date)
    }
    
    func setupBoxOfficeData() {
        movieManager.fetchBoxOfficeResultData(date: Date.movieDateToString) { result in
            switch result {
            case .success(let success):
                self.reloadCollectionListData(result: success)
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
        movieManager.fetchBoxOfficeResultData(date: Date.movieDateToString) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.applyBoxOfficeList(result: success)
                    guard
                        let date = success.showRange.toDateFromRange()
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
    
    func reloadCollectionListData(result: BoxOfficeResult) {
        DispatchQueue.main.async {
            self.boxOfficeListView.indicatorView.stopAnimating()
            self.configureNavigation(date: Date.yesterday)
            self.applyBoxOfficeList(result: result)
            self.boxOfficeListView.isScrollEnabled = true
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BoxOfficeViewController: BoxOfficeListViewDelegate {
    func applyBoxOfficeListView() {
        DispatchQueue.main.async {
            self.updateBoxOfficeList()
        }
    }
}
