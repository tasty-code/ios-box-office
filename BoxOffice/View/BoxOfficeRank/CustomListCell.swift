//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/10.
//

import UIKit

final class CustomListCell: UICollectionViewListCell {

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

        let rankStackView = UIVerticalStackView(arrangedSubviews: [rankNumberLabel, rankDetailLabel], alignment: .center)

        let movieStackView = UIVerticalStackView(arrangedSubviews: [movieNameLabel, movieDetailLabel], alignment: .leading)

        contentView.addSubview(rankStackView)
        contentView.addSubview(movieStackView)

        NSLayoutConstraint.activate([
            rankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.RankStackView.vertical),
            rankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.RankStackView.vertical),
            rankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.RankStackView.leading),
            rankStackView.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.RankStackView.width),
            rankStackView.widthAnchor.constraint(equalToConstant: Constants.RankStackView.width),

            movieStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.MovieStackView.vertical),
            movieStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.MovieStackView.vertical),
            movieStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: Constants.MovieStackView.leading)
        ])
    }

}
