//
//  BoxOfficeListController.swift
//  BoxOffice
//
//  Created by M&A on 13/01/23.
//

import UIKit

final class BoxOfficeListController: UIViewController {
    
    // MARK: - Constants
        
    enum Section: Int, CaseIterable {
        case list
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeListCell.Item>
    
    // MARK: - Properties
    
    private let viewModel: BoxOfficeListViewModel
    private lazy var dataSource: DataSource = makeDataSource()
    
    // MARK: - UI Components
    
    private lazy var boxOfficeListCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionview.refreshControl = refreshControl
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        activityIndicator.style = .medium
        return activityIndicator
    }()
    
    // MARK: - Initialization
    
    init(viewModel: BoxOfficeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
        notifyViewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func notifyViewDidLoad() {
        viewModel.input = .viewDidLoad
    }
    
    private func bindViewModel() {
        
        viewModel.output.$cellItems.bind { [weak self] items in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                self.setAnimatingActivityIndicator(isAnimated: false)
                
                self.appendSnapshot(with: items)
            }
        }
        
        viewModel.output.$selectedDate.bind { [weak self] date in
            guard let self = self else { return }
            self.title = date.formatted("yyyy-MM-dd")
        }
    }
    
    @objc private func didRefresh() {
        viewModel.input = .isRefreshed
    }
}

// MARK: - UI & Layout

extension BoxOfficeListController {
    
    private func setup() {
        setUI()
        setLayout()
        setupCollectionView()
    }
    
    private func setUI() {
        setBackgroundColor()
        setAnimatingActivityIndicator(isAnimated: true)
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setAnimatingActivityIndicator(isAnimated: Bool) {
        guard isAnimated != activityIndicator.isAnimating else { return }
        
        if isAnimated {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func setLayout() {
        view.addSubview(boxOfficeListCollectionView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            boxOfficeListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            boxOfficeListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            boxOfficeListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boxOfficeListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        boxOfficeListCollectionView.registerCell(cellClass: BoxOfficeListCell.self)
        setupInitialSnapshot()
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

// MARK: - DataSource / Snapshot

extension BoxOfficeListController {
    
    private func makeDataSource() -> DataSource {
        UICollectionViewDiffableDataSource(
            collectionView: boxOfficeListCollectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let section = Section(rawValue: indexPath.section) else {
                    return UICollectionViewCell()
                }
                switch section {
                case .list:
                    let cell = collectionView.dequeueReusableCell(cellClass: BoxOfficeListCell.self, for: indexPath)
                    cell.configure(with: item)
                    return cell
                }
            }
        )
    }
    
    private func setupInitialSnapshot() {
        // Section 초기 설정
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(Section.allCases)
        dataSource.apply(snapshot)
    }
    
    private func appendSnapshot(with items: [BoxOfficeListCell.Item]) {
        // list snapshot 설정
        var listSnapshot = NSDiffableDataSourceSectionSnapshot<BoxOfficeListCell.Item>()
        listSnapshot.append(items)
        dataSource.apply(listSnapshot, to: .list)
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct BoxOfficeListControllerPreView: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: DIContainer.shared.makeBoxOfficeListController())
            .toPreview()
    }
}
#endif
