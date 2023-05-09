//
//  MovieViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class MovieViewController: UIViewController {

    var collectionView: UICollectionView?

    var movieArrays: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        setupCollectionView()
        registerCollectionViewCell()

        do {
            let api = URLPath.dailyBoxOffice(date: "20230501")
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
                    self?.collectionView?.reloadData()
                }
            }
        } catch {
            print(error)
        }
//
        func makeUI() {
            view.backgroundColor = .white

            title = "20230501"
        }
    }

    private func registerCollectionViewCell() {
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
    }

    func setupCollectionView() {
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
}

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

