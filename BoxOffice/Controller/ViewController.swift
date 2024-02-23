//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class ViewController: UIViewController {
    private let boxOfficeListView: BoxOfficeListView = BoxOfficeListView()
    private let movieManager: MovieManager
    
    init(movieManager: MovieManager) {
        self.movieManager = movieManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = boxOfficeListView
        boxOfficeListView.collectionView.dataSource = self
        setupBoxOfficeData()
        configureNavigation()
    }
}

private extension ViewController {
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
            case .success(_):
                self.reloadCollectionListData()
            case .failure(let failure):
                print("fetchBoxOfficeResultData 실패: \(failure)")
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieManager.movieCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard 
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.identifier, for: indexPath) as? MovieCollectionCell
        else {
            return UICollectionViewListCell()
        }
        guard
            let MovieList = movieManager.dailyBoxOfficeData?.boxOfficeResult.dailyBoxOfficeList
        else {
            return UICollectionViewListCell()
        }
        let movieResult = MovieList[indexPath.row]
        cell.configure(result: movieResult)
        cell.accessories = [.disclosureIndicator()]
        return cell
    }
    
    func reloadCollectionListData() {
        DispatchQueue.main.async {
            self.boxOfficeListView.collectionView.reloadData()
        }
    }
}
