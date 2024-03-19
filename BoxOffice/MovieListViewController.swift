//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//
import SwiftUI
import UIKit

final class MovieListViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    private var boxOfficeDataArray:[DailyBoxOfficeDTO.BoxOfficeDTO.MovieInfo] = []
    let apiBuilder = APIURLBuilder()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let CV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return CV
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        return refreshControl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Date().yesterday
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        setupCollectionView()
        view.addSubview(activityIndicator)
        
        Task {
            let data = try await networkManager.performRequest(with: apiBuilder.buildDailyBoxOfficeAPI(targetDate: APIURLCompnents.QueryValues.targetDate ?? ""))
                
            guard let DTO = JSONParser().decode(data, DTO: DailyBoxOfficeDTO.self),
                  let boxOfficeList = DTO.boxOfficeResult.dailyBoxOfficeList
            else {
                return
            }
            
            boxOfficeDataArray = boxOfficeList
            collectionView.reloadData()
            activityIndicator.isHidden = true
        }
    }
    
    @objc
    func reload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell else {
            fatalError("fatalError")
        }
        cell.configureCell(with: boxOfficeDataArray[indexPath.row])
        cell.addSubview(MovieListCollectionViewCell())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        boxOfficeDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}



//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    
//    // update
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
//        
//    }
//    // makeui
//    @available(iOS 13.0, *)
//    func makeUIViewController(context: Context) -> UIViewController {
//        MovieListViewController()
//    }
//}
//
//struct ViewController_Previews: PreviewProvider {
//    static var previews: some View{
//        ViewControllerRepresentable().previewDisplayName("아이폰 15프로")
//    }
//}

