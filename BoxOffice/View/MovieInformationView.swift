//
//  MovieInformationView.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

final class MovieInformationView: UIView {
    
    private let loadingIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let scrollView: UIScrollView = UIScrollView()
    private let imageView: UIImageView = UIImageView(image: nil)
    private let detailInformationStackView: UIStackView = UIStackView(axis: .vertical, distribution: .fillProportionally)
    
    private let directorStackView: InformationStackView = InformationStackView().setTitleText("감독")
    private let productionYearStackView: InformationStackView = InformationStackView().setTitleText("제작년도")
    private let openDateStackView: InformationStackView = InformationStackView().setTitleText("개봉일")
    private let showTimeStackView: InformationStackView = InformationStackView().setTitleText("상영시간")
    private let auditsStackView: InformationStackView = InformationStackView().setTitleText("관람등급")
    private let nationsStackView: InformationStackView = InformationStackView().setTitleText("제작국가")
    private let genresStackView: InformationStackView = InformationStackView().setTitleText("장르")
    private let actorsStackView: InformationStackView = InformationStackView().setTitleText("배우")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.addSubview(loadingIndicatorView)
        loadingIndicatorView.startAnimating()
        setScrollView()
        addDetailInformationStackViewSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieInformationView {
    func insertData(data: MovieInformation.MovieDetail) {
        directorStackView.contentLabel.text = data.directors
        productionYearStackView.contentLabel.text = data.productionYear
        openDateStackView.contentLabel.text = data.openDate
        showTimeStackView.contentLabel.text = data.showTime
        auditsStackView.contentLabel.text = data.audits
        nationsStackView.contentLabel.text = data.nations
        genresStackView.contentLabel.text = data.genres
        actorsStackView.contentLabel.text = data.actors
    }
    
    func appendImage(_ image: UIImage?) {
        loadingIndicatorView.stopAnimating()
        imageView.image = image
    }
}

extension MovieInformationView {
    private func addDetailInformationStackViewSubview() {
        detailInformationStackView.addArrangedSubview(directorStackView)
        detailInformationStackView.addArrangedSubview(productionYearStackView)
        detailInformationStackView.addArrangedSubview(openDateStackView)
        detailInformationStackView.addArrangedSubview(showTimeStackView)
        detailInformationStackView.addArrangedSubview(auditsStackView)
        detailInformationStackView.addArrangedSubview(nationsStackView)
        detailInformationStackView.addArrangedSubview(genresStackView)
        detailInformationStackView.addArrangedSubview(actorsStackView)
    }
    
    private func setScrollView() {
        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(detailInformationStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        detailInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            detailInformationStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            detailInformationStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            detailInformationStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            loadingIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            loadingIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: imageView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: detailInformationStackView.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
