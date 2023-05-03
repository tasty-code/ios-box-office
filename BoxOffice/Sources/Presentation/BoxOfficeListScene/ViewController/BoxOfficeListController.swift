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
    
    private let dailyBoxOfficeList: [DailyBoxOffice]! = {
        let data = MockData.boxOffice
        let decodedData = try? JSONDecoder().decode(DailyBoxOfficeResponse.self, from: data!)
        return decodedData?.boxOfficeResult.dailyBoxOfficeList
    }()
    
    // MARK: - UI Components
    
    private lazy var boxOfficeListCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
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
        setCurrentDateTitle()
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubview(boxOfficeListCollectionView)
        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
    
    private func setCurrentDateTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: Date())
        title = formattedDate
    }
}

// MARK: UICollectionViewDataSource

extension BoxOfficeListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: BoxOfficeListCell.self, for: indexPath)
        
        let boxOffice = dailyBoxOfficeList[indexPath.row]
        cell.configure(with: boxOffice)
        
        return cell
    }
}
