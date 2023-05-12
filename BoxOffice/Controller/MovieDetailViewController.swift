//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Bora Yang on 2023/05/11.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private let scrollView = UIScrollView()

    private var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    private var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()


    func stackViewfor8() {
        for i in 1...100 {
            let movieInformationView = MovieInformaionView(category: "야하 \(i)", content: "이히")
            movieStackView.addArrangedSubview(movieInformationView)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(movieImageView)
        contentView.addArrangedSubview(movieStackView)

        setLayout()
        stackViewfor8()
    }

    func setImage(image: UIImage) {
        movieImageView.image = image
    }
    
    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            movieImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.3 / 1),

            movieStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
        ])
    }
}
