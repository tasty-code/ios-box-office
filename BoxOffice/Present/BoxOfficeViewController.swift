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
        requstBoxOfficeData()
        configureRefreshControl()
    }
    
    // MARK: - Private Function
    
    private func formatDateString(_ dateString: String) -> String {
        let yearIndex = dateString.index(dateString.startIndex, offsetBy: 0)
        let monthIndex = dateString.index(dateString.startIndex, offsetBy: 4)
        let dayIndex = dateString.index(dateString.startIndex, offsetBy: 6)
        
        let year = dateString[yearIndex..<monthIndex]
        let month = dateString[monthIndex..<dayIndex]
        let day = dateString[dayIndex...]
        
        return "\(year)-\(month)-\(day)"
    }
    
    private func configureNavigationBar() {
        let dateString = Date.yesterdayFormatted
        let formattedDateString = formatDateString(dateString)
        self.navigationItem.title = formattedDateString
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
    
    private func configureRefreshControl() {
        
        movieCollectionView.refreshControl = UIRefreshControl()
        let refreshControl = movieCollectionView.refreshControl
        refreshControl?.addTarget(self, action:
                                    #selector(handleRefreshControl),
                                  for: .valueChanged)
        refreshControl?.tintColor = UIColor.systemYellow
        refreshControl?.attributedTitle = NSAttributedString(
            string: "새로고침",
            attributes: [.foregroundColor: UIColor.systemPink]
        )
    }
    
    private func configureCollectionView() {
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(BoxOfficeCollectionViewListCell.self, forCellWithReuseIdentifier: "BoxOfficeCollectionViewListCell")
    }
    
    private func requstBoxOfficeData() {
        let date = Date.yesterdayFormatted
        
        NetworkManager.shared.fetchDailyBoxOffice(for: date) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.boxOfficeData = data
                    self?.movieCollectionView.reloadData()
                case .failure(let error):
                    self?.presentAlert(title: "네트워크 요청이 실패 했습니다.\n다시 시도 해주세요.\n(\(error))")
                }
            }
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @objc func handleRefreshControl() {
        
        requstBoxOfficeData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.movieCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionCount = boxOfficeData?.boxOfficeResult.dailyBoxOfficeList.count else { return 0 }
        return sectionCount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewListCell.identifier, for: indexPath) as? BoxOfficeCollectionViewListCell else {
            return UICollectionViewCell()
        }
        
        guard let singleData = boxOfficeData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.movieData = singleData
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
