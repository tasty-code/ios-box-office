//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//


import UIKit

class BoxOfficeViewController: UIViewController, DailyFormatter{
    private var dailyBoxOfficeList: [BoxOfficeEntity] = []
    private let refreshControl = UIRefreshControl()
    let dailyBoxOffice = DailyBoxOfficeUseCase()
    
    private var boxOfficeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = dailyFormatter(format: "yyyy-MM-dd")
        configureView()
        addView()
        setLayout()
        initRefresh()
        executeDailyBoxOffice()
    }
    
    private func executeDailyBoxOffice() {
        dailyBoxOffice.execute(complection: { [self] result in
            dailyBoxOfficeList = result

            DispatchQueue.main.async {
                self.boxOfficeCollectionView.reloadData()
            }
        })
    }
    
    private func configureView() {
        boxOfficeCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        boxOfficeCollectionView.dataSource = self
    }
    
    private func addView() {
        view.addSubview(boxOfficeCollectionView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            boxOfficeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boxOfficeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            boxOfficeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            boxOfficeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func initRefresh() {
        refreshControl.addTarget(self, action: #selector(updatUI(refresh:)), for: .valueChanged)
        boxOfficeCollectionView.refreshControl = refreshControl
    }
    
    @objc func updatUI(refresh: UIRefreshControl) {
        executeDailyBoxOffice()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.boxOfficeCollectionView.reloadData()
            refresh.endRefreshing()
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: dailyBoxOfficeList[indexPath.row])
        cell.accessories = [.disclosureIndicator()]
        return cell
    }

}
