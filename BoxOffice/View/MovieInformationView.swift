//
//  MovieInformationView.swift
//  BoxOffice
//
//  Created by Kim EenSung on 3/8/24.
//

import UIKit

class MovieInformationView: UIScrollView {
    
    private let stackView: UIStackView = UIStackView(axis: .vertical, distribution: .fillProportionally)
    private let imageView: UIImageView = UIImageView(image: nil)
    private let detailInformationStackView: UIStackView = UIStackView(axis: .vertical, distribution: .fillProportionally)
    
    private lazy var directorStackView: UIStackView = informationStackViewFactory(title: "감독")
    private lazy var productionYearStackView: UIStackView = informationStackViewFactory(title: "제작년도")
    private lazy var openDateStackView: UIStackView = informationStackViewFactory(title: "개봉일")
    private lazy var showTimeStackView: UIStackView = informationStackViewFactory(title: "상영시간")
    private lazy var auditsStackView: UIStackView = informationStackViewFactory(title: "관람등급")
    private lazy var nationsStackView: UIStackView = informationStackViewFactory(title: "제작국가")
    private lazy var genresStackView: UIStackView = informationStackViewFactory(title: "장르")
    
    private var actorsStackView: UIStackView = {
        let actorsStackView: UIStackView = UIStackView(axis: .horizontal, distribution: .fillProportionally)
        let titleLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
        let contentView: UITextView = UITextView()
        contentView.isEditable = false
        
        actorsStackView.addArrangedSubview(titleLabel)
        actorsStackView.addArrangedSubview(contentView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: actorsStackView.widthAnchor, multiplier: 0.2).isActive = true
        contentView.widthAnchor.constraint(equalTo: actorsStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        return actorsStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addDetailInformationStackViewSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieInformationView {
    private func informationStackViewFactory(title: String) -> UIStackView {
        let stackView: UIStackView = UIStackView(axis: .horizontal, distribution: .fillProportionally)
        let titleLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
        let contentLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .body), textAlignment: .left)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
        
        titleLabel.text = title
        return stackView
    }
    
    private func addDetailInformationStackViewSubview() {
        detailInformationStackView.addArrangedSubview(directorStackView)
        detailInformationStackView.addArrangedSubview(productionYearStackView)
        detailInformationStackView.addArrangedSubview(openDateStackView)
        detailInformationStackView.addArrangedSubview(showTimeStackView)
        detailInformationStackView.addArrangedSubview(showTimeStackView)
        detailInformationStackView.addArrangedSubview(auditsStackView)
        detailInformationStackView.addArrangedSubview(nationsStackView)
        detailInformationStackView.addArrangedSubview(genresStackView)
    }
    
    private func setScrollView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(detailInformationStackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

