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

    lazy var movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    func stackViewfor8() {
        for i in 1...8 {
            let movieInformationView = MovieInformaionView(category: "야하 \(i)", content: "이히")
            movieStackView.addArrangedSubview(movieInformationView)
        }
    }

    override func viewDidLoad() {   
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(movieImageView)
        view.addSubview(movieStackView)
        setLayout()
        stackViewfor8()
    }

    func setImage(image: UIImage) {
        movieImageView.image = image
    }
    
    func setLayout() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
//        infoStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            movieStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),

//            infoStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            infoStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
}
