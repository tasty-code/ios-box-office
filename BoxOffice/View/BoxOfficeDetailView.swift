//
//  BoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by Matthew on 3/8/24.
//

import UIKit

class BoxOfficeDetailView: UIScrollView {
    
    let directorView = ReusedDetailStackView()
    let productYearView = ReusedDetailStackView()
    let openDateView = ReusedDetailStackView()
    let showTimeView = ReusedDetailStackView()
    let watchGradeView = ReusedDetailStackView()
    let nationsView = ReusedDetailStackView()
    let genresView = ReusedDetailStackView()
    let actorsView = ReusedDetailStackView()
    
    lazy var movieInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            directorView,
            productYearView,
            openDateView,
            showTimeView,
            watchGradeView,
            nationsView,
            genresView,
            actorsView
        ])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    lazy var innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let movieImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo.fill")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        directorView.setupStackView(title: "", contents: [""])
        productYearView.setupStackView(title: "", contents: [""])
        openDateView.setupStackView(title: "", contents: [""])
        showTimeView.setupStackView(title: "", contents: [""])
        watchGradeView.setupStackView(title: "", contents: [""])
        nationsView.setupStackView(title: "", contents: [""])
        genresView.setupStackView(title: "", contents: [""])
        actorsView.setupStackView(title: "", contents: [""])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(innerView)
        innerView.addSubview(movieImageView)
        innerView.addSubview(movieInfoStackView)
    }
    
    func setupConstraints() {
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor).isActive = true
        innerView.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor).isActive = true
        innerView.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor).isActive = true
        innerView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor).isActive = true
        
        innerView.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor).isActive = true
        innerView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 10).isActive = true
        movieImageView.centerXAnchor.constraint(equalTo: innerView.centerXAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: innerView.widthAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: innerView.widthAnchor).isActive = true
        
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10).isActive = true
        movieInfoStackView.leadingAnchor.constraint(equalTo: innerView.leadingAnchor).isActive = true
        movieInfoStackView.trailingAnchor.constraint(equalTo: innerView.trailingAnchor).isActive = true
    }
}
