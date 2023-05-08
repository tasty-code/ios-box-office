//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class DailyBoxOfficeViewController: UIViewController {

    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOffice>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, DailyBoxOffice>

    private let boxOfficeManager = BoxOfficeAPIManager()
    private var dataSource: DataSource?
    private var dailyBoxOfficeCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureCollectionView()
    }

    private func setUp() {
        navigationItem.title = "데이터 받아오는 중~!"
        view.backgroundColor = .systemBackground
    }

    private func configureCollectionView() {
        dailyBoxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        guard let dailyBoxOfficeCollectionView else { return }
        view.addSubview(dailyBoxOfficeCollectionView)
        dailyBoxOfficeCollectionView.register(DailyBoxOfficeCell.self,
                                              forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
        configureCollectionViewLayoutConstraint()
    }

    private func configureCollectionViewLayoutConstraint() {
        guard let dailyBoxOfficeCollectionView else { return }
        let safeAreaGuide = view.safeAreaLayoutGuide

        dailyBoxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dailyBoxOfficeCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor).isActive = true
        dailyBoxOfficeCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor).isActive = true
        dailyBoxOfficeCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        dailyBoxOfficeCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)

            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }

        return layout
    }

}

