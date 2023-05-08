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
        guard let dailyBoxOfficeCollectionView = dailyBoxOfficeCollectionView else { return }
        view.addSubview(dailyBoxOfficeCollectionView)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)

            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }

        return layout
    }

}

