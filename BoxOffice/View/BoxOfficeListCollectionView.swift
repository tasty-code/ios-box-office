import UIKit

protocol BoxOfficeListDelegate: AnyObject {
    func refreshBoxOfficeList()
}

final class BoxOfficeListCollectionView: UICollectionView {
    weak var boxofficeListDelegate: BoxOfficeListDelegate?
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    private lazy var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addAction(UIAction { [weak self] _ in self?.refreshBoxOfficeCollectionView() }, for: .valueChanged)
        return refreshControl
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleLoadingIndicator(shouldStart: Bool) {
        shouldStart ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    
    private func setupCollectionView() {
        registerCells()
        configureLoadingIndicator()
        self.refreshControl = pullToRefreshControl
    }
    
    private func registerCells() {
        self.register(BoxOfficeListViewListCell.self, forCellWithReuseIdentifier: BoxOfficeListViewListCell.reuseIdentifier)
    }
    
    private func configureLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        self.isScrollEnabled = true
    }
    
    private func refreshBoxOfficeCollectionView() {
            self.boxofficeListDelegate?.refreshBoxOfficeList()
    }
}
