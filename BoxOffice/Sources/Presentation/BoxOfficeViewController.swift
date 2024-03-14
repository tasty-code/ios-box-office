//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//


import UIKit

class BoxOfficeViewController: UIViewController {
    
    private lazy var boxOfficeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "오늘 날짜"
        configureView()
        addView()
        setLayout()
    }
    
    private func configureView() {
        boxOfficeCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        boxOfficeCollectionView.delegate = self
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
}

extension BoxOfficeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
