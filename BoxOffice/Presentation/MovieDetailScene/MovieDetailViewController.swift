//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by EUNJU on 3/12/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    private let movieDetailTableView = UITableView()
    
    init() {
        // TODO: viewmodel 주입 필요
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpLayout()
        setUpNavigationBar()
        setUpTableView()
        registerCell()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
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
    
    private func setUpNavigationBar() {
        // TODO: fetch 해온 영화 제목 넣기
        self.navigationItem.title = "영화 제목"
    }
    
    private func setUpTableView() {
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
    }
    
    private func registerCell() {
        movieDetailTableView.register(MovieInfoTableViewCell.self,
                                      forCellReuseIdentifier: String(describing: MovieInfoTableViewCell.self))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 8
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieInfoTableViewCell.self), for: indexPath) as? MovieInfoTableViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}
