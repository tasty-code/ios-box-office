//
//  MovieCollectionCell.swift
//  BoxOffice
//
//  Created by Matthew on 2/21/24.
//

import UIKit

final class MovieCollectionCell: UICollectionViewListCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    private var rankStackView = RankStackView()
    private var movieStackView = MovieStackView()
    
    private lazy var boxOfficeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rankStackView, movieStackView])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieCollectionCell {
    func setupView() {
        self.addSubview(boxOfficeStackView)
    }
    
    func setupConstraints() {
        rankStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 5).isActive = true
        boxOfficeStackView.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        boxOfficeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        boxOfficeStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        boxOfficeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
}

extension MovieCollectionCell {
    func configure(result: DailyBoxOfficeList) {
        rankStackView.configure(
            rank: result.rank,
            rankState: result.rankOldAndNew.rawValue,
            rankChanged: result.rankChanged)
        movieStackView.configureStackView(
            movieName: result.name,
            totalAudience: result.audiencesAccumulated,
            todayAudience: result.audiencesCount)
    }
}
