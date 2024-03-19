//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by EUNJU on 3/12/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    private let viewModel: MovieDetailViewModel
    private let movieCode: Observable<String>
    private let movieName: Observable<String>
    private var movieDetailTableView = UITableView()
    private var movieDetail: MovieEntity?
    private var moviePoster: MoviePosterEntity?
    
    init(viewModel: MovieDetailViewModel, movieCode: Observable<String>, movieName: Observable<String>) {
        self.viewModel = viewModel
        self.movieCode = movieCode
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpLayout()
        setUpNavigationBar(movieName: "")
        setUpTableView()
        registerCell()
        bindViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        movieDetailTableView.separatorStyle = .none
    }
    
    private func setUpLayout() {
        view.addSubview(movieDetailTableView)
        movieDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpNavigationBar(movieName: String) {
        self.navigationItem.title = movieName
    }
    
    private func setUpTableView() {
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
    }
    
    private func registerCell() {
        movieDetailTableView.register(MovieInfoTableViewCell.self,
                                      forCellReuseIdentifier: String(describing: MovieInfoTableViewCell.self))
        movieDetailTableView.register(MovieImageTableViewCell.self, forCellReuseIdentifier: String(describing: MovieImageTableViewCell.self))
    }
    
    private func bindViewModel() {
        let input = MovieDetailViewModel.Input(
            viewDidLoad: Observable(()),
            refreshAction: Observable(()),
            movieCode: movieCode, 
            movieName: movieName
        )
        let output = viewModel.transform(input: input)
        
        output.movieDetail.subscribe { [weak self] movieEntity in
            guard let movieEntity = movieEntity else { return }
            self?.movieDetail = movieEntity
            self?.setUpNavigationBar(movieName: movieEntity.movieName)
            self?.movieDetailTableView.reloadData()
        }
        
        output.moviePoster.subscribe { [weak self] moviePoster in
            guard let moviePoster = moviePoster else { return }
            self?.moviePoster = moviePoster
            self?.movieDetailTableView.reloadData()
        }
        
        output.networkError.subscribe { [weak self] result in
            if result {
                self?.presentAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 8
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieImageTableViewCell.self), for: indexPath) as? MovieImageTableViewCell,
        let infoCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieInfoTableViewCell.self), for: indexPath) as? MovieInfoTableViewCell
        else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            imageCell.setUpData(with: moviePoster)
            return imageCell
        case 1:
            let info = movieDetail?.getInfoArray()[indexPath.row]
            infoCell.setUpData(with: info)
            return infoCell
        default:
            return UITableViewCell()
        }
    }
}
