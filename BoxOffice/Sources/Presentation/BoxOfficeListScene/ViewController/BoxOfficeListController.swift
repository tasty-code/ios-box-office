//
//  BoxOfficeListController.swift
//  BoxOffice
//
//  Created by M&A on 13/01/23.
//

import UIKit

final class BoxOfficeListController: UIViewController {
    
    // MARK: - Constants
    
    enum Metric {}
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var boxOfficeListCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )
    
    // MARK: - Initialization
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
}

// MARK: - UI & Layout

extension BoxOfficeListController {
    
    private func setup() {
        setUI()
        setLayout()
        setupCollectionView()
    }
    
    private func setUI() {
        
    }
    
    private func setLayout() {
        view.addSubview(boxOfficeListCollectionView)
        boxOfficeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        boxOfficeListCollectionView.registerCell(cellClass: BoxOfficeListCell.self)
        boxOfficeListCollectionView.dataSource = self
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

// MARK: UICollectionViewDataSource

extension BoxOfficeListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: BoxOfficeListCell.self, for: indexPath)
        return cell
    }
}
