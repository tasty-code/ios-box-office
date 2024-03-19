//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    private let movieManager: MovieManager = MovieManager()
    private let boxOfficeListView: BoxOfficeListView = {
        let configure = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
        let view = BoxOfficeListView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private lazy var dataSource = BoxOfficeListDataSource(self.boxOfficeListView)
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoxOfficeListView()
        setupBoxOfficeData()
    }
}

private extension BoxOfficeViewController {
    func configureNavigation(date: Date) {
        self.title = Date.titleDateFormatter.string(from: date)
    }
    
    func setupBoxOfficeListView() {
        LoadingIndicatorView.showLoading()
        boxOfficeListView.boxOfficeListDelegate = self
        boxOfficeListView.delegate = self
        boxOfficeListView.dataSource = dataSource
        view = boxOfficeListView
    }
    
    func setupBoxOfficeData() {
        Task {
            do {
                let result = try await movieManager.fetchBoxOfficeResultData(date: Date.movieDateToString)
                self.reloadCollectionListData(result: result)
                LoadingIndicatorView.hideLoading()
            } catch {
                print(error.localizedDescription)
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
        Task {
            do {
                let result = try await self.movieManager.fetchBoxOfficeResultData(
                    date: Date.movieDateToString
                )
                self.applyBoxOfficeList(result: result)
                guard
                    let date = result.showRange.toDateFromRange()
                else {
                    return
                }
                self.configureNavigation(date: date)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func reloadCollectionListData(result: BoxOfficeResult) {
        DispatchQueue.main.async {
            self.configureNavigation(date: Date.yesterday)
            self.applyBoxOfficeList(result: result)
            self.boxOfficeListView.isScrollEnabled = true
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard 
            let data = movieManager.setupBoxOfficeDetailData(for: indexPath.row)
        else {
            return
        }
        let detailViewController = BoxOfficeDetailViewController(
            movieName: data.movieName,
            movieCode: data.movieCode,
            movieManager: movieManager
        )
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension BoxOfficeViewController: BoxOfficeListViewDelegate {
    func applyBoxOfficeListView() {
        DispatchQueue.main.async {
            self.updateBoxOfficeList()
        }
    }
}
