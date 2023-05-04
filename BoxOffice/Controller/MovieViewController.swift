//
//  MovieViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class MovieViewController: UIViewController {

    var collectionView: UICollectionView?

    var movieArrays: [Movie] = [Movie(name: "존 윅 4", rank: BoxOffice.Rank(rank: 3, isEntry: false, variance: 0), audience: BoxOffice.Audience(today: 65019, accumulate: 1663651), code: 20231089)]

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        setupCollectionView()
        registerCollectionViewCell()

        do {
            let api = URLPath.dailyBoxOffice(date: "20230501")
            let url = try api.configureURL()
            let urlRequest = URLRequest(url: url)

            Networking().loadData(api.convertType, request: urlRequest) { data, error in
                guard error == nil else {
                    print(error as Any)
                    return
                }

                guard let data = data else {
                    print("빈 데이터입니다")
                    return
                }
                print(data)
            }
        } catch {
            print(error)
        }

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
//        flowLayout.scrollDirection = .vertical

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
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell

        return cell
    }


}

