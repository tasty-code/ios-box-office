//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    // MARK: - Public Property
    
    // MARK: - Private Property
    
    private var boxOfficeData: BoxOfficeDTO?
    
    // MARK: - View
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
        configureAutoLayout()
        configureCollectionView()
    }
    
    // MARK: - Private Function
    
    private func configureNavigationBar() {
        self.navigationItem.title = "네비게이션바"
    }
    
    private func configureUI() {
        view.addSubview(movieCollectionView)
    }
    
    private func configureAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(BoxOfficeCollectionViewListCell.self, forCellWithReuseIdentifier: "BoxOfficeCollectionViewListCell")
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier, for: indexPath) as? BoxOfficeCollectionViewListCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
