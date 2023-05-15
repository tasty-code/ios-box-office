//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

final class CustomListCell: UICollectionViewListCell {

    enum Constants {
        
        static let rankStackViewVertical: CGFloat = 10
        static let rankStackViewLeading: CGFloat = 30
        static let rankStackViewWidth: CGFloat = 50
        
        static let movieStackViewVertical: CGFloat = 15
        static let movieStackViewLeading: CGFloat = 20
        static let movieStackViewTrailing: CGFloat = -30
    }
    
    var boxOfficeItem: BoxOfficeItem?

    private let rankNumberLabel = UILabel(fontSize: .largeTitle)
    private let rankDetailLabel = UILabel(fontSize: .callout)
    private let movieNameLabel = UILabel(fontSize: .title3)
    private let movieDetailLabel = UILabel()

    override func updateConfiguration(using state: UICellConfigurationState) {

        super.updateConfiguration(using: state)

        configureHierarchy()
        configureSeparator()

        rankNumberLabel.text = boxOfficeItem?.rank.number
        rankDetailLabel.attributedText = boxOfficeItem?.rank.detail
        movieNameLabel.text = boxOfficeItem?.name
        movieDetailLabel.text = boxOfficeItem?.audience
    }
    
    private func configureSeparator() {

        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        constraint.isActive = true
    }

    private func configureHierarchy() {
        
        self.accessories = [.disclosureIndicator()]
    
        let rankStackView = UIVerticalStackView(arrangedSubviews: [rankNumberLabel, rankDetailLabel], alignment: .center)
        let movieStackView = UIVerticalStackView(arrangedSubviews: [movieNameLabel, movieDetailLabel], alignment: .leading)

        contentView.addSubview(rankStackView)
        contentView.addSubview(movieStackView)

        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.rankStackViewVertical),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.rankStackViewVertical),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.rankStackViewLeading),
            rankStackView.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.rankStackViewWidth),
            rankStackView.widthAnchor.constraint(equalToConstant: Constants.rankStackViewWidth),

            movieStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.movieStackViewVertical),
            movieStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.movieStackViewVertical),
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: Constants.movieStackViewLeading),
            movieStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.movieStackViewTrailing)
        ])
    }

}
