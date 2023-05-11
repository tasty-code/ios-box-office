//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/11.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    var categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(contentLabel)
        return stackView
    }()

    override func viewDidLoad() {   
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(movieImageView)
        view.addSubview(infoStackView)
        setLayout()
        categoryLabel.text = "안녕"
        contentLabel.text = "하세요"
    }


    func setLayout() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor)
        ])
    }
}
