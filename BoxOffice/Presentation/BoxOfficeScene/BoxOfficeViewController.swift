//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by nayeon  on 2/26/24.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private let viewModel: BoxOfficeViewModel
    private var refreshAction: Observable<Void> = Observable(())
    private var boxOfficeList: [BoxOfficeEntity] = []
    
    init(viewModel: BoxOfficeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureUI()
        setupConstraint()
        setupNavigationBar()
        setupRefreshControl()
        bindViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }

    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

    private func setupNavigationBar() {
        let dateString = Date.convertYesterdayDateToString()
        let formattedDateString = formatDateString(dateString)
        self.navigationItem.title = formattedDateString
    }

    // TODO: 위치 옮기기
    private func formatDateString(_ dateString: String) -> String {
        let yearIndex = dateString.index(dateString.startIndex, offsetBy: 0)
        let monthIndex = dateString.index(dateString.startIndex, offsetBy: 4)
        let dayIndex = dateString.index(dateString.startIndex, offsetBy: 6)
        
        let year = dateString[yearIndex..<monthIndex]
        let month = dateString[monthIndex..<dayIndex]
        let day = dateString[dayIndex...]
        
        return "\(year)-\(month)-\(day)"
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: BoxOfficeCollectionViewCell.self))
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshBoxOfficeData(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshBoxOfficeData(_ sender: UIRefreshControl) {
        refreshAction.value = ()
        sender.endRefreshing()
    }
    
    private func bindViewModel() {
        let input = BoxOfficeViewModel.Input(
            viewDidLoad: Observable(()),
            refreshAction: refreshAction)
        let output = viewModel.transform(input: input)
        
        output.boxOfficeData.subscribe { [weak self] result in
            self?.boxOfficeList = result
            self?.collectionView.reloadData()
        }
        
        output.networkError.subscribe { [weak self] result in
            if result {
                self?.presentAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BoxOfficeCollectionViewCell.self), for: indexPath) as? BoxOfficeCollectionViewCell 
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: boxOfficeList[indexPath.row])
        
        return cell
    }
}

extension BoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovieCode = Observable<String>(boxOfficeList[indexPath.item].movieCode)
        
        let movieDetailVC = MovieDetailViewController(
            viewModel: MovieDetailViewModel(
                movieUseCase: DefaultMovieUseCase(
                    movieRepository: DefaultMovieRepository(
                        apiService: MovieAPIService(provider: NetworkProvider())
                    )
                )
            ),
            movieCode: selectedMovieCode
        )
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
