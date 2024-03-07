import UIKit

class BoxOfficeListViewController: UIViewController {
    private var movieAPIFetcher: MovieAPIFetcher
    private var dailyBoxOfficeList: [CustomDailyBoxOffice] = []
    private var movieListCollectionView: BoxOfficeListView?
    
    
    init(fetcher: MovieAPIFetcher) {
        self.movieAPIFetcher = fetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         

    }
    
}

extension BoxOfficeListViewController {
    private func configureNavigationBarTitle() {
         navigationItem.title = Date.todayStringFormatter
         let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
         navigationController?.navigationBar.titleTextAttributes = attributes
     }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 100)
        movieListCollectionView = BoxOfficeListView(frame: .zero, collectionViewLayout: layout)
        guard let movieListCollectionView = movieListCollectionView else { return }
        view.addSubview(movieListCollectionView)
        movieListCollectionView.frame = view.bounds
    }
    
    private func fetchBoxOfficeData() {
        movieAPIFetcher.fetchBoxOffice { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let boxOfficeList):
                    self?.dailyBoxOfficeList = boxOfficeList
                    self?.movieListCollectionView?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension BoxOfficeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeListViewCell.reuseIdentifier, for: indexPath) as? BoxOfficeListViewCell else {
            fatalError("BoxOfficeListViewCell dequeueReusableCell Error ")
        }
        let boxOffice = dailyBoxOfficeList[indexPath.row]
        cell.configure(with: boxOffice)
        cell.accessories = [.disclosureIndicator()]
        return cell
    }
}
