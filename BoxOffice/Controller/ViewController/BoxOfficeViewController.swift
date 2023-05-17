//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    private var dataSource: UICollectionViewDataSource?
    private let presentationProvider = PresentationProvider()
    
    private var boxOffices: [BoxOfficeItem] {
        self.presentationProvider.getBoxOffices()
    }
    
    private lazy var collectionView = BoxOfficeCollectionView(frame: .zero)
    private lazy var indicatorView = ActivityIndicatorView(frame: view.bounds)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        collectionView.delegate = self

        configureHierarchy()
        setupInitialBoxOffices()
        configureRefreshControl()
    }
    
    private func configureHierarchy() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
        configureSelectDateButton()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupInitialBoxOffices() {
        
        presentationProvider.loadBoxOffices()
        configureDataSource {
            self.indicatorView.stopAnimating()
        }
    }
    
    private func configureDataSource(completionHandler: @escaping (() -> Void)) {

        presentationProvider.boxOfficeCall = {
            let boxOfficeDataSource = BoxOfficeDataSource()
            boxOfficeDataSource.boxOffices = self.boxOffices
            self.dataSource = boxOfficeDataSource

            DispatchQueue.main.async {
                self.title = self.presentationProvider.getBoxOfficeDate()
                self.collectionView.dataSource = self.dataSource
                completionHandler()
            }
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectMovie = boxOffices[indexPath.item]
        let movieInformationViewController = MovieInformationViewController(movieCode: selectMovie.movieCode)
        movieInformationViewController.title = selectMovie.name

        navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}

extension BoxOfficeViewController {

    func configureRefreshControl() {
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {

        self.presentationProvider.loadBoxOffices()
        self.collectionView.isScrollEnabled = false

        configureDataSource {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.isScrollEnabled = true
        }
    }
}

extension BoxOfficeViewController {

    func configureSelectDateButton() {
        
        let dateButton = UIBarButtonItem(title: "날짜선택", style: .plain, target: self, action: #selector(dateButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = dateButton
    }

    @objc func dateButtonAction(_ sender: UIBarButtonItem) {
        
        let calendarViewController = CalendarViewController()
        calendarViewController.changedDate = { date in
            self.indicatorView.startAnimating()
            self.presentationProvider.updateDate(date)
        }
        self.present(calendarViewController, animated: true)
    }
}

