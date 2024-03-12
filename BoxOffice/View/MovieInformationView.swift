//
//  MovieInformationView.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

final class MovieInformationView: UIView {
    
    private let scrollView: UIScrollView = UIScrollView()
    private let stackView: UIStackView = UIStackView(axis: .vertical, distribution: .fillProportionally)
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
        
        setScrollView()
        addDetailInformationStackViewSubview()
        imageView.image = UIImage(systemName: "photo")
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
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(detailInformationStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
}
