//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
        setupConstraint()
        setupNavigationBar()
    }
}

extension BoxOfficeViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }

    func setupConstraint() {
        let safaArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safaArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safaArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safaArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safaArea.bottomAnchor)
        ])
    }

    func setupNavigationBar() {

    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "BoxOfficeCollectionViewCell")

    }
}

// MARK: - Extension

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as? BoxOfficeCollectionViewCell else {
            return UICollectionViewCell()
        }
       
        return cell
    }
}

extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
